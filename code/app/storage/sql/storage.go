package sql

import (
	"app/app/storage"

	"github.com/jmoiron/sqlx"
)

type Storage struct {
	db            *sqlx.DB
	serialStorage *SerialStorage
}

func NewStorage(database *sqlx.DB) *Storage {
	return &Storage{
		db: database,
	}
}

func (s *Storage) Serial() storage.SerialStorage {
	if s.serialStorage != nil {
		return s.serialStorage
	}

	s.serialStorage = &SerialStorage{
		storage: s,
	}

	return s.serialStorage
}
