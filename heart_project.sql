CREATE TABLE heart_raw_data(
age text,sex text,cp text,trestbps text,chol text,fbs text,restecg text,thalach text,
exang text,oldpeak text,slope text,ca text,thal text,target text
);

COPY heart_raw_data FROM 'C:/Program Files/PostgreSQL/New folder/archive (22)/heart.csv'
WITH(FORMAT CSV,HEADER true,ENCODING 'utf8'); 

CREATE TABLE heart_clean_data(
age int,sex int,cp int,trestbps int,chol int,fbs int,restecg int,thalach int,exang int,
oldpeak numeric(3,2),slope int,ca int,thal int,target int);

INSERT INTO heart_clean_data(age,sex,cp,trestbps,chol,fbs,restecg,thalach,exang,oldpeak,
slope,ca,thal,target)
SELECT
NULLIF(age,'')::int,
NULLIF(sex,'')::int,NULLIF(cp,'')::int,NULLIF(trestbps,'')::int,
NULLIF(chol,'')::int,NULLIF(fbs,'')::int,NULLIF(restecg,'')::int,
NULLIF(thalach,'')::int,NULLIF(exang,'')::int,NULLIF(oldpeak,'')::numeric,
NULLIF(slope,'')::int,NULLIF(ca,'')::int,NULLIF(thal,'')::int,NULLIF(target,'')::int
from heart_raw_data;

CREATE VIEW clinical_heart_data AS
SELECT 
age,
CASE WHEN sex=1 THEN 'Male'
     WHEN sex=0 THEN 'Female'
	 END AS sex,
CASE WHEN cp=0 THEN 'Typical Angina'
     WHEN cp=1 THEN 'Atypical Angina'
	 WHEN cp=2 THEN 'Non-anginal Pain'
	 WHEN cp=3 THEN 'Asymptomatic'
	 END AS chest_pain_type,	 
trestbps,
chol,
CASE WHEN fbs=1 THEN 'High(>120 mg/dl)'
     WHEN fbs=0 THEN 'Normal(<=120 mg/dl)'
	 END AS fasting_blood_sugar,
CASE WHEN restecg=0 THEN 'Normal'
     WHEN restecg=1 THEN 'ST-T Wave Abnormality'
	 WHEN restecg=2 THEN 'Left Ventricular Hypertrophy'
	 END AS resting_ecg,
thalach,
CASE WHEN exang=1 THEN 'Yes'
     WHEN exang=0 THEN 'No'
	 END AS exercise_induced_angina, 
oldpeak,
CASE WHEN slope=0 THEN 'Downsloping'
     WHEN Slope=1 THEN 'Flat'
	 WHEN slope=2 THEN 'Upsloping'
	 END AS st_slope, 
ca,
CASE WHEN thal=0 THEN 'Unknown'
     WHEN thal=1 THEN 'Normal'
	 WHEN thal=2 THEN 'Fixed Defect'
	 WHEN thal=3 THEN 'Reversible Defect'
	 END AS thalassemia,
CASE WHEN target=1 THEN 'Heart Disease'
     WHEN target=0 THEN 'No Disease'
	 END AS diagnosis
FROM heart_clean_data;


select * from heart_clean_data;
SELECT * FROM clinical_heart_data;












