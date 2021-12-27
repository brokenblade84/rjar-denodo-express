use db;

CREATE TABLE `User` (
	Id INT AUTO_INCREMENT PRIMARY KEY,
	Username VARCHAR(30) NOT NULL,
		CONSTRAINT UQ__Usuario__Username UNIQUE (Username),
	first_name VARCHAR(50) NOT NULL,
	passwrd VARCHAR(44) NOT NULL,
	last_name VARCHAR(50) NOT NULL,	
	is_blocked BOOLEAN NOT NULL,
	email VARCHAR(320) NOT NULL,
	    CONSTRAINT UQ__Usuario__Email UNIQUE (Email),
	create_date DATETIME NOT NULL,
	update_date DATETIME NULL,
	delete_Date DATETIME NULL,
	create_user_id INT NOT NULL,
	update_user_id INT NULL,
        CONSTRAINT fk__user__update_user
        FOREIGN KEY (update_user_id) REFERENCES User(Id),
	delete_user_id INT NULL,
        CONSTRAINT fk__user__delete_user
        FOREIGN KEY (delete_user_id) REFERENCES User(Id)
);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario1', 'Usuario', '123456', 'Usuario', 0, 'Usuario1@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario2', 'Usuario', '123456', 'Usuario', 0, 'Usuario2@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario3', 'Usuario', '123456', 'Usuario', 0, 'Usuario3@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario4', 'Usuario', '123456', 'Usuario', 0, 'Usuario4@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario5', 'Usuario', '123456', 'Usuario', 0, 'Usuario5@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario6', 'Usuario', '123456', 'Usuario', 0, 'usuario6@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario7', 'Usuario', '123456', 'Usuario', 0, 'usuario7@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario8', 'Usuario', '123456', 'Usuario', 0, 'usuario8@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario9', 'Usuario', '123456', 'Usuario', 0, 'usuario9@gmail.com', NOW(), null, null, 1, null, null);

INSERT INTO db.`User`
(Username, first_name, passwrd, last_name, is_blocked, email, create_date, update_date, delete_Date, create_user_id, update_user_id, delete_user_id)
VALUES('usuario10', 'Usuario', '123456', 'Usuario', 0, 'usuario10@gmail.com', NOW(), null, null, 1, null, null);
