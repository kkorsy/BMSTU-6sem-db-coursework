package repositories

import (
	"app/internal/models"

	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
)

type CommentsRepo struct {
	db  *sqlx.DB
	log *logrus.Logger
}

func NewCommentsRepo(db *sqlx.DB, log *logrus.Logger) *CommentsRepo {
	return &CommentsRepo{db: db, log: log}
}

func (repo *CommentsRepo) GetComments() ([]*models.Comments, error) {
	repo.log.Info("Getting all comments from the database")
	comments := []*models.Comments{}
	err := repo.db.Select(&comments, "SELECT * FROM comments")
	if err != nil {
		return nil, err
	}
	return comments, nil
}

func (repo *CommentsRepo) GetCommentById(id int) (*models.Comments, error) {
	repo.log.Info("Getting comment by id from the database")
	comment := &models.Comments{}
	err := repo.db.Get(comment, "SELECT * FROM comments WHERE c_id=$1", id)
	if err != nil {
		return nil, err
	}
	return comment, nil
}

func (repo *CommentsRepo) GetCommentsBySerialId(idSerial int) ([]*models.Comments, error) {
	repo.log.Info("Getting comments by serial from the database")
	comments := []*models.Comments{}
	err := repo.db.Select(&comments, "SELECT * FROM comments WHERE c_idSerial=$1", idSerial)
	if err != nil {
		return nil, err
	}
	return comments, nil
}

func (repo *CommentsRepo) GetCommentsByUserId(idUser int) ([]*models.Comments, error) {
	repo.log.Info("Getting comments by user from the database")
	comments := []*models.Comments{}
	err := repo.db.Select(&comments, "SELECT * FROM comments WHERE c_idUser=$1", idUser)
	if err != nil {
		return nil, err
	}
	return comments, nil
}

func (repo *CommentsRepo) GetCommentsBySerialIdUserId(idSerial, idUser int) (*models.Comments, error) {
	repo.log.Info("Getting comments by serial and user from the database")
	comment := &models.Comments{}
	err := repo.db.Get(comment, "SELECT * FROM comments WHERE c_idSerial=$1 AND c_idUser=$2", idSerial, idUser)
	if err != nil {
		return nil, err
	}
	return comment, nil
}

func (repo *CommentsRepo) CreateComment(comment *models.Comments) error {
	if !comment.Validate() {
		return models.ErrInvalidModel
	}
	var id int64

	repo.log.Info("Creating comment in the database")
	err := repo.db.QueryRow("INSERT INTO comments (c_text, c_date, c_idUser, c_idSerial) VALUES ($1, $2, $3, $4) RETURNING c_id",
		comment.GetText(), comment.GetDate(), comment.GetIdUser(), comment.GetIdSerial()).Scan(&id)
	if err != nil {
		return err
	}
	comment.SetId(int(id))

	return nil
}

func (repo *CommentsRepo) UpdateComment(comment *models.Comments) error {
	if !comment.Validate() {
		return models.ErrInvalidModel
	}

	repo.log.Info("Updating comment in the database")
	_, err := repo.db.Exec("UPDATE comments SET c_text=$1, c_date=$2, c_idUser=$3 WHERE c_id=$4",
		comment.GetText(), comment.GetDate(), comment.GetIdUser(), comment.GetId())

	if err != nil {
		return err
	}

	return nil
}

func (repo *CommentsRepo) DeleteComment(id int) error {
	repo.log.Info("Deleting comment from the database")
	_, err := repo.db.Exec("DELETE FROM comments WHERE c_id=$1", id)
	if err != nil {
		return err
	}

	return nil
}

func (repo *CommentsRepo) CheckComment(idUser, idSerial int) bool {
	repo.log.Info("Checking if comment exists in the database")
	var id int
	err := repo.db.Get(&id, "SELECT c_id FROM comments WHERE c_idUser=$1 AND c_idSerial=$2", idUser, idSerial)
	return err == nil
}
