package main

import (
	"app/config"
	"app/internal/server"
	"app/logger"
	"net/http"

	// "app/tech_ui"

	log_default "log"

	"github.com/BurntSushi/toml"
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
)

func main() {
	cfg := config.Config{}
	_, err := toml.DecodeFile("config/config.toml", &cfg)
	if err != nil {
		log_default.Fatal(err)
	}
	log, err := logger.InitLog(cfg.Log_path)
	if err != nil {
		log.Fatal(err)
	}

	db, err := sqlx.Connect(cfg.Db_type, cfg.Db_url)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// tech_ui.Run(db, log)

	s := server.NewServer(log, db, cfg.SessionKey)

	err = http.ListenAndServe(cfg.Port, s)
	if err != nil {
		log.Fatal(err)
	}
}
