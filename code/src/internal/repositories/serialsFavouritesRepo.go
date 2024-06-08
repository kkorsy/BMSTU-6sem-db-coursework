package repositories

import (
	"app/internal/models"

	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
)

type SerialsFavouritesRepo struct {
	db  *sqlx.DB
	log *logrus.Logger
}

func NewSerialsFavouritesRepo(db *sqlx.DB, log *logrus.Logger) *SerialsFavouritesRepo {
	return &SerialsFavouritesRepo{db: db, log: log}
}

func (repo *SerialsFavouritesRepo) GetSerialsFavourites() ([]*models.SerialsFavourites, error) {
	repo.log.Info("Getting all serials_favourites from the database")
	serialsFavourites := []*models.SerialsFavourites{}
	err := repo.db.Select(&serialsFavourites, "SELECT * FROM serials_favourites")
	if err != nil {
		return nil, err
	}
	return serialsFavourites, nil
}

func (repo *SerialsFavouritesRepo) GetSerialsFavouritesById(id int) (*models.SerialsFavourites, error) {
	repo.log.Info("Getting serials_favourites by id from the database")
	serialFavourite := &models.SerialsFavourites{}
	err := repo.db.Get(serialFavourite, "SELECT * FROM serials_favourites WHERE sf_id=$1", id)
	if err != nil {
		return nil, err
	}
	return serialFavourite, nil
}

func (repo *SerialsFavouritesRepo) GetSerialsByFavouriteId(id int) ([]*models.SerialsFavourites, error) {
	repo.log.Info("Getting serials_favourites by favourite id from the database")
	serialsFavourites := []*models.SerialsFavourites{}
	err := repo.db.Select(&serialsFavourites, "SELECT * FROM serials_favourites WHERE sf_idFavourite=$1", id)
	if err != nil {
		return nil, err
	}
	return serialsFavourites, nil
}

func (repo *SerialsFavouritesRepo) GetFavouritesBySerialId(id int) ([]*models.SerialsFavourites, error) {
	repo.log.Info("Getting serials_favourites by serial id from the database")
	serialsFavourites := []*models.SerialsFavourites{}
	err := repo.db.Select(&serialsFavourites, "SELECT * FROM serials_favourites WHERE sf_idSerial=$1", id)
	if err != nil {
		return nil, err
	}
	return serialsFavourites, nil
}

func (repo *SerialsFavouritesRepo) CreateSerialsFavourites(serialFavourite *models.SerialsFavourites) error {
	if !serialFavourite.Validate() {
		return models.ErrInvalidModel
	}
	var id int64

	repo.log.Info("Creating serials_favourites in the database")
	err := repo.db.QueryRow("INSERT INTO serials_favourites (sf_idSerial, sf_idFavourite) VALUES ($1, $2) RETURNING sf_id",
		serialFavourite.GetIdSerial(), serialFavourite.GetIdFavourite()).Scan(&id)
	if err != nil {
		return err
	}
	serialFavourite.SetId(int(id))

	return nil
}

func (repo *SerialsFavouritesRepo) UpdateSerialsFavourites(serialFavourite *models.SerialsFavourites) error {
	if !serialFavourite.Validate() {
		return models.ErrInvalidModel
	}

	repo.log.Info("Updating serials_favourites in the database")
	_, err := repo.db.Exec("UPDATE serials_favourites SET sf_idSerial=$1, sf_idFavourite=$2 WHERE sf_id=$3",
		serialFavourite.GetIdSerial(), serialFavourite.GetIdFavourite(), serialFavourite.GetId())

	if err != nil {
		return err
	}

	return nil
}

func (repo *SerialsFavouritesRepo) CheckSerialInFavourite(serialFavourite *models.SerialsFavourites) bool {
	repo.log.Info("Checking serial in favourite")
	sf_temp := []*models.SerialsFavourites{}
	err := repo.db.Select(&sf_temp, "SELECT * FROM serials_favourites WHERE sf_idSerial=$1 AND sf_idFavourite=$2",
		serialFavourite.GetIdSerial(), serialFavourite.GetIdFavourite())
	repo.log.Println(err, sf_temp, err == nil)
	return len(sf_temp) != 0
}

func (repo *SerialsFavouritesRepo) DeleteSerialById(idfav, idserial int) error {
	repo.log.Info("Deleting serials_favourites from the database")
	_, err := repo.db.Exec("DELETE FROM serials_favourites WHERE sf_idFavourite=$1 AND sf_idSerial=$2", idfav, idserial)
	if err != nil {
		return err
	}
	return nil
}

func (repo *SerialsFavouritesRepo) DeleteSerialsFavourites(id int) error {
	repo.log.Info("Deleting serials_favourites from the database")
	_, err := repo.db.Exec("DELETE FROM serials_favourites WHERE sf_id=$1", id)
	if err != nil {
		return err
	}
	return nil
}
