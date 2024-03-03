package sql

import (
	"app/app/models"
	"app/app/storage"
	"database/sql"
)

type SerialStorage struct {
	storage *Storage
}

func (s *SerialStorage) Find(id int) (*models.Serial, error) {
	s_found := &models.Serial{}
	err := s.storage.db.QueryRow(
		"SELECT * FROM Serials WHERE id = $1",
		id,
	).Scan(
		&s_found.ID,
		&s_found.IDProducer,
		&s_found.Name,
		&s_found.Description,
		&s_found.Year,
		&s_found.Genre,
		&s_found.Rating,
		&s_found.Seasons,
		&s_found.State,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, storage.ErrNotFound
		}
		return nil, err
	}

	return s_found, nil
}

func (s *SerialStorage) GetAll() ([]*models.Serial, error) {
	s_list := []*models.Serial{}
	res, err := s.storage.db.Query(
		"SELECT * FROM Serials",
	)
	if err != nil {
		return nil, err
	}
	defer res.Close()

	for res.Next() {
		curSerial := &models.Serial{}
		err = res.Scan(
			&curSerial.ID,
			&curSerial.IDProducer,
			&curSerial.Name,
			&curSerial.Description,
			&curSerial.Year,
			&curSerial.Genre,
			&curSerial.Rating,
			&curSerial.Seasons,
			&curSerial.State,
		)
		if err != nil {
			return nil, err
		}
		s_list = append(s_list, curSerial)
	}
	return s_list, nil
}
