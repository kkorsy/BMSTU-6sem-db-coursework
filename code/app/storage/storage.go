package storage

import (
	"app/app/models"
	"errors"
)

var ErrNotFound = errors.New("record not found")

type Storage interface {
	Serial() SerialStorage
}

type SerialStorage interface {
	Find(int) (*models.Serial, error)
	GetAll() ([]*models.Serial, error)
}
