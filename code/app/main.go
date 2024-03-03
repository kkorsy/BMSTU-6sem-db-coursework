package main

import (
	"app/app/handlers"
	"log"

	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
)

func main() {
	db, err := sqlx.Connect("postgres", "user=postgres dbname=serials password=5454038 host=localhost port=5432 sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = handlers.Start(db)
	if err != nil {
		log.Fatal(err)
	}
}
