package handlers

import (
	"app/app/storage"
	"app/app/storage/sql"
	"fmt"
	"html/template"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/jmoiron/sqlx"
)

type server struct {
	router  *mux.Router
	storage storage.Storage
}

func NewServer(db *sqlx.DB) *server {
	s := &server{
		router:  mux.NewRouter(),
		storage: sql.NewStorage(db),
	}
	s.InitRouter()

	return s
}

func Start(db *sqlx.DB) error {
	s := NewServer(db)

	fmt.Println("starting server at :8080")
	return http.ListenAndServe(":8080", s.router)
}

func (s *server) InitRouter() {
	// init
	s.router.HandleFunc("/", s.StartHandler())
	s.router.HandleFunc("/auth", s.AuthHandler())
	// s.router.HandleFunc("/signin", s.SignInHandler())
	// s.router.HandleFunc("/reg", s.RegHandler())

	// user

	// admin
}

func (s *server) StartHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		res, err := s.storage.Serial().GetAll()
		if err != nil {
			fmt.Println("no rows")
			return
		}
		tmpl, _ := template.ParseFiles("../front/start.html")

		tmpl.Execute(w, res)
	}
}

func (s *server) AuthHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "../front/auth.html")
	}
}

// func (s *server) SignInHandler() http.HandlerFunc {
// 	return func (w http.ResponseWriter, r *http.Request) {
// 		login := r.FormValue("login")
// 		password := r.FormValue("password")

// 	}
// }

// func (s *server) RegHandler() http.HandlerFunc {
// 	return func (w http.ResponseWriter, r *http.Request) {

// 	}
// }
