package models

type Serial struct {
	ID          int
	IDProducer  int
	Name        string
	Description string
	Year        int
	Genre       string
	Rating      float32
	Seasons     int
	State       string
}
