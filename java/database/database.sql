BEGIN TRANSACTION;

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS foodIntake CASCADE;
DROP TABLE IF EXISTS profile CASCADE;
DROP TABLE IF EXISTS hydration CASCADE;
DROP TABLE IF EXISTS weight CASCADE;

DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) UNIQUE NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);


CREATE TABLE foodIntake (
	food_intake_id serial NOT NULL,
	user_id int NOT NULL,
	food_type varchar(50) NOT NULL,
	serving_size NUMERIC(10,2) NOT NULL,
	number_of_servings NUMERIC(10,2) NOT NULL,
	calories NUMERIC(10,2) NOT NULL,
	carbs NUMERIC(10,2) NOT NULL,
	fats NUMERIC(10,2) NOT NULL,
	proteins NUMERIC(10,2) NOT NULL,
	meal_type varchar(10) NOT NULL,
	day_of_meal date NOT NULL,
	
	CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT PK_food_intake PRIMARY KEY (food_intake_id)
);

CREATE TABLE hydration (
   hydration_id serial NOT NULL,
   user_id int NOT NULL,
   curr_date date NOT NULL,
   amount_drank NUMERIC(10,2),
   CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES users(user_id),
   CONSTRAINT PK_hydration_id PRIMARY KEY (hydration_id)
);

CREATE TABLE profile (
	profile_id serial NOT NULL,
	user_id int NOT NULL,
	display_name varchar(64),
	photo varchar(500),
	birthday date,
	age int,
	height_feet int,
	height_inches int,
	current_weight int,
	goal_weight int,
	CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT PK_profile PRIMARY KEY (profile_id)
);

CREATE TABLE weight (
   weight_id serial NOT NULL,
   user_id int NOT NULL,
   curr_date date NOT NULL,
   curr_weight NUMERIC(10,2),
   CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES users(user_id),
   CONSTRAINT PK_weight_id PRIMARY KEY (weight_id)
);

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

INSERT INTO profile (user_id) VALUES (1);
INSERT INTO profile (user_id) VALUES (2);


INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 350, 35, 14, 17, 'lunch', '2022-04-22');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'cereal', 1, 1, 307, 55, 5, 11, 'breakfast', '2022-04-22');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 148, 7, 13, 4, 'lunch', '2022-04-21');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'cereal', 1, 1, 307, 55, 5, 11, 'breakfast', '2022-04-21');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 350, 35, 14, 17, 'lunch', '2022-04-20');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'cereal', 1, 1, 307, 55, 5, 11, 'breakfast', '2022-04-20');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'soup', 1, 1, 433, 23, 29, 21, 'dinner', '2022-04-19');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 409, 48, 14, 22, 'lunch', '2022-04-19');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'cereal', 1, 1, 307, 55, 5, 11, 'breakfast', '2022-04-18');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'soup', 1, 1, 433, 23, 29, 21, 'dinner', '2022-04-18');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 409, 48, 14, 22, 'lunch', '2022-04-17');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'steak', 1, 1, 679, 0, 48, 62, 'dinner', '2022-04-17');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 350, 35, 14, 17, 'lunch', '2022-04-16');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'bacon and eggs', 1, 1, 500, 25, 30, 25, 'breakfast', '2022-04-16');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-04-15');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'cereal', 1, 1, 307, 55, 5, 11, 'breakfast', '2022-04-15');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'soup', 1, 1, 433, 23, 29, 21, 'dinner', '2022-04-14');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 409, 48, 14, 22, 'lunch', '2022-04-14');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'steak', 1, 1, 679, 0, 48, 62, 'dinner', '2022-04-13');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-04-13');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'bacon and eggs', 1, 1, 500, 25, 30, 25, 'breakfast', '2022-04-13');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'potatoes', 1, 1, 300, 45, 10, 5, 'dinner', '2022-04-12');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 409, 48, 14, 22, 'lunch', '2022-04-11');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-04-10');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 148, 7, 13, 4, 'lunch', '2022-04-09');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-04-08');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 148, 7, 13, 4, 'lunch', '2022-04-07');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-04-07');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'soup', 1, 1, 433, 23, 29, 21, 'lunch', '2022-04-06');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 148, 7, 13, 4, 'lunch', '2022-04-06');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-04-05');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-04-04');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'bacon and eggs', 1, 1, 500, 25, 30, 25, 'breakfast', '2022-04-03');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'potatoes', 1, 1, 300, 45, 10, 5, 'dinner', '2022-04-03');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-04-02');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-04-02');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 148, 7, 13, 4, 'lunch', '2022-04-01');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-31');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-30');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-29');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-28');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 148, 7, 13, 4, 'lunch', '2022-03-27');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-27');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-26');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-26');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-26');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-25');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-25');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 148, 7, 13, 4, 'lunch', '2022-03-25');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-25');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-25');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-25');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-24');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-24');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-23');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-23');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-22');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-21');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-20');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-19');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-19');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-18');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-18');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-17');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-17');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-16');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-16');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-16');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-15');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-15');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-14');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-14');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-14');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-13');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-13');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-12');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-12');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-11');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-11');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-10');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-10');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-09');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-09');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-08');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-08');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-08');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-07');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-07');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-06');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-06');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-05');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-05');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-04');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-04');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-03');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-03');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-02');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'burger', 1, 1, 400, 45, 30, 25, 'lunch', '2022-03-02');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 300, 25, 20, 10, 'lunch', '2022-03-02');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'sandwhich', 1, 1, 350, 45, 20, 10, 'lunch', '2022-03-01');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'tomato soup', 1, 1, 300, 20, 20, 5, 'lunch', '2022-03-01');
INSERT INTO foodintake (user_id, food_type, serving_size, number_of_servings, calories, carbs, fats, proteins, meal_type, day_of_meal)
VALUES (2, 'salad', 1, 1, 250, 10, 25, 10, 'lunch', '2022-03-01');


INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-22', 221);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-21', 224);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-20', 224);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-19', 222);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-18', 223);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-17', 225);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-16', 224);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-15', 226);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-14', 225);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-13', 226);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-12', 225);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-11', 227);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-10', 226);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-09', 226);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-08', 227);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-07', 225);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-06', 226);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-05', 229);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-04', 228);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-03', 228);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-02', 229);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-04-01', 230);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-31', 227);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-30', 230);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-29', 229);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-28', 230);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-27', 234);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-26', 232);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-25', 233);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-24', 230);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-23', 233);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-22', 234);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-21', 237);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-20', 235);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-19', 234);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-18', 238);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-17', 239);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-16', 238);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-15', 235);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-14', 238);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-13', 242);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-12', 241);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-11', 240);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-10', 243);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-09', 242);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-08', 239);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-07', 243);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-06', 242);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-05', 244);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-04', 243);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-03', 246);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-02', 244);

INSERT INTO weight (user_id, curr_date, curr_weight)
VALUES (2, '2022-03-01', 245);




/*added some hydration test data*/

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/22',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/21',85);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/20',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/14',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/15',85);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/16',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/17',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/18',95);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/19',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/13',100);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/12',95);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/11',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/10',70);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/09',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/08',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/07',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/06',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/05',95);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/04',100);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/03',100);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/02',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/04/01',85);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/31',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/30',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/29',70);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/28',65);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/27',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/26',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/25',95);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/24',100);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/23',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/22',95);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/21',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/20',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/19',95);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/18',85);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/17',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/16',75);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/15',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/14',110);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/13',100);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/12',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/11',95);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/10',100);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/09',105);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/08',100);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/07',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/06',85);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/05',80);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/04',85);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/03',90);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/02',65);

INSERT INTO hydration (user_id,curr_date,amount_drank)
VALUES (2,'2022/03/01',50);

--- USER SETUP (Do Not Modify)
DROP USER IF EXISTS final_capstone_owner;
DROP USER IF EXISTS final_capstone_appuser;

CREATE USER final_capstone_owner
WITH PASSWORD 'finalcapstone';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO final_capstone_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_owner;

CREATE USER final_capstone_appuser
WITH PASSWORD 'finalcapstone';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO final_capstone_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_appuser;

COMMIT TRANSACTION;