-- ==========================================
--     Solutions to the 25 exercises    -----
-- ==========================================



-- 1 CRUD Operations : Insérer un nouveau patient nommé "Alex Johnson", né le 15 juillet 1990, de sexe masculin, avec le numéro de téléphone "1234567890".
INSERT INTO patients 
(first_name, last_name, gender, date_of_birth, phone_number, email, address) 
VALUES
('Alex', 'Johnson', 'Male', '1990-07-15', '1234567890', 'alexjohnson@mail.com', 'Marrakech');


--2 SELECT Statement : Récupérez tous les départements avec leurs emplacements.

SELECT location 
FROM departments;


--3 ORDER BY Clause : Trier les patients par date de naissance Listez tous les patients, triés par date de naissance dans l'ordre croissant.

SELECT * 
FROM patients 
ORDER BY date_of_birth

-- 4 Filtrer les patients uniques par sexe (DISTINCT) Récupérez tous les sexes des patients enregistrés, sans doublons.

SELECT DISTINCT gender 
FROM patients 

-- 5 LIMIT Clause : Obtenir les 3 premiers médecins Récupérez les trois premiers médecins dans la table doctors.

SELECT  *
FROM doctors LIMIT 3;



--6 WHERE Clause : Patients nés après 2000 Récupérez les informations des patients nés après l'année 2000.

SELECT * 
FROM patients 
WHERE YEAR(date_of_birth)  > 2000; 


-- 7 Logical Operators : Médecins dans des départements spécifiques Récupérez les médecins des départements "Cardiology" et "Neurology".


SELECT * 
FROM doctors 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name IN ('Cardiology','Neurology'));


--8 Special Operators : Vérifier des plages de dates Listez les admissions entre le 1er décembre et le 7 décembre 2024.

SELECT * FROM admissions 
WHERE MONTH(admission_date) = 12 
AND DAY(admission_date) BETWEEN 1 AND 7
AND YEAR(admission_date) = 2024;


--9 Conditional Expressions : Nommer les catégories d'âge des patients Ajoutez une colonne catégorisant les patients en "Enfant", "Adulte", ou "Senior" selon leur âge.

ALTER TABLE patients
ADD categories ENUM ('Enfant','Adulte','Senior');

UPDATE patients
SET categories = CASE 
    WHEN (YEAR(CURRENT_DATE) - YEAR(date_of_birth))  < 18 THEN 'Enfant'
    WHEN (YEAR(CURRENT_DATE) - YEAR(date_of_birth))  BETWEEN 18 AND 35 THEN 'Adulte'
    ELSE 'Senior'
END

--10 Aggregate Functions : Nombre total de rendez-vous Comptez le nombre total de rendez-vous enregistrés.
    SELECT count(*) FROM appointments


--11 COUNT avec GROUP BY : Comptez le nombre de médecins dans chaque département.

    
SELECT 
    department_id, 
    COUNT(*) AS total_doctors
FROM doctors 
GROUP BY department_id
ORDER BY total_doctors DESC;

--12 AVG : Calculez l'âge moyen des patients.

SELECT AVG((YEAR(CURRENT_DATE) - YEAR(date_of_birth))) FROM patients


--13 : Dernier rendez-vous Trouvez la date et l'heure du dernier rendez-vous enregistré.

    SELECT MAX(*) FROM appointments

--14 SUM : Total des admissions par chambre Calculez le total des admissions pour chaque chambre.
SELECT 
    room_id, 
    COUNT(*) AS total_admissions
FROM admissions
GROUP BY room_id;

--15 Constraints : Vérifier les patients sans e-mail Récupérez tous les patients dont le champ email est vide.
    SELECT * FROM  patient WHERE email IS NULL OR email = '';
    
    --16 Jointure : Liste des rendez-vous avec noms des médecins et patients Récupérez les rendez-vous avec les noms des médecins et des patients.
    SELECT 
    appointments.appointment_id, 
    patients.first_name AS patient_name, 
    doctors.first_name AS doctor_name     
    FROM patients
    JOIN appointments 
        ON patients.patient_id = appointments.patient_id 
    JOIN doctors 
        ON appointments.doctor_id = doctors.doctor_id;
    --17 DELETE : Supprimez tous les rendez-vous programmés avant 2024.

    DELETE 
    FROM appointments 
    WHERE YEAR(appointment_date) < 2024;

    --18 UPDATE : Changez le nom du département "Oncology" en "Cancer Treatment".

    UPDATE departments
    SET department_name = 'Cancer Treatment'
    WHERE department_name = 'Oncology'

    --19 HAVING Clause : Patients par sexe avec au moins 2 entrées Listez les genres ayant au moins deux patients.

    SELECT count(*), gender
    FROM patients
    GROUP BY gender

    --20 Créer une vue : Admissions actives Créez une vue listant toutes les admissions en cours.

    CREATE VIEW admissions_actives AS
    SELECT * 
    FROM admissions 



--====================================================
---------Questions bonus pour les jointures: ---------
--====================================================


-- Bonus 1: Patients et leurs médecins traitants

    -- Récupérez les noms des patients et les noms de leurs médecins traitants à partir des tables patients, admissions, et doctors.

    SELECT patients.first_name AS patient_name,doctors.first_name AS doctor_name
    FROM patients
    JOIN appointments ON appointments.appointment_id = patients.patient_id
    JOIN doctors ON doctors.doctor_id = appointments.doctor_id



    -- Bonus 2: Liste des rendez-vous par département

    -- Récupérez la liste des rendez-vous avec les départements associés.
    SELECT departments.department_name 
    FROM departments
    JOIN doctors ON departments.department_id = doctors.department_id
    JOIN appointments ON appointments.doctor_id = doctors.doctor_id

    -- Bonus 3: Médicaments prescrits par médecin

    -- Listez les médicaments prescrits par chaque médecin.

    SELECT doctors.first_name AS doctor_name,medications.medication_name
    FROM doctors
    JOIN appointments ON appointments.doctor_id = doctors.doctor_id
    JOIN prescriptions ON prescriptions.patient_id = appointments.patient_id
    JOIN medications ON medications.medication_id = prescriptions.medication_id;



    -- Bonus 4: Admissions et leurs chambres associées

    -- Récupérez les informations des admissions et des chambres où les patients sont placés.

    SELECT 
    patients.first_name AS patient_name,
    admissions.admission_date,
    admissions.discharge_date,
    rooms.room_number
    FROM patients
    JOIN admissions ON admissions.patient_id = patients.patient_id
    JOIN rooms ON rooms.room_id = admissions.room_id;


    -- Bonus 5: Statistiques des patients par département

    -- Comptez le nombre de patients associés à chaque département via leurs admissions.
    SELECT d.department_name, count(patients.patient_id) AS total_patient
    FROM departments as d
    JOIN doctors ON doctors.department_id = d.department_id
    JOIN appointments ON appointments.doctor_id	= doctors.doctor_id
    JOIN patients ON patients.patient_id = appointments.patient_id 
    JOIN admissions ON admissions.patient_id = patients.patient_id
    GROUP BY d.department_id









