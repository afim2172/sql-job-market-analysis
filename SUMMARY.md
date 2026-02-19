# Rapport Final du Projet : Analyse du Marché de l'Emploi Data

## 1. Objectif du Projet
Ce projet visait à simuler un environnement de Data Engineering réel pour analyser les tendances du marché de l'emploi dans la donnée (Data Analyst, Data Engineer, Data Scientist).
L'objectif était de répondre à des questions stratégiques sur les salaires et les compétences demandées, tout en optimisant la performance de la base de données.

## 2. Architecture Technique
- **Base de Données** : PostgreSQL 15+
- **Schéma** : Modèle en étoile (Star Schema)
  - `job_postings_fact` (Table de faits : 200+ offres)
  - `company_dim`, `skills_dim` (Dimensions)
  - `skills_job_dim` (Table de liaison Many-to-Many)
- **ETL** : Python (Pandas) pour la génération et nettoyage, SQL (`COPY`) pour le chargement.

## 3. Résultats et Insights Clés
Suite à l'analyse SQL, voici les découvertes majeures sur ce jeu de données simulé :
1.  **Top Droles** : Les postes de **Senior Analytics Engineer** et **Data Architect** dominent souvent le classement des salaires, dépassant parfois les Data Scientists purs.
2.  **Compétences Lucratives** :
    - Des compétences cloud spécifiques (ex: **Snowflake**, **Databricks**) sont corrélées à des salaires plus élevés que des compétences génériques (Excel).
    - **Python** et **SQL** restent les compétences les plus demandées (volume d'offres), confirmant leur statut de "must-have".
3.  **Télétravail** : Les postes en "Remote" offrent des salaires compétitifs, souvent alignés sur les marchés technologiques majeurs (SF, NY) indépendamment de la localisation du candidat.

## 4. Optimisation des Performances
Pour préparer le passage à l'échelle (Big Data), nous avons optimisé les requêtes :
- **Problème identifié** : Les requêtes de filtrage utilisaient un `Seq Scan` (lecture complète de la table), ce qui est inefficace sur de gros volumes.
- **Solution** : Création d'index B-Tree sur les colonnes de filtrage fréquentes :
  ```sql
  CREATE INDEX idx_job_title_short ON job_postings_fact(job_title_short);
  CREATE INDEX idx_salary_year_avg ON job_postings_fact(salary_year_avg);
  ```
- **Résultat** : Réduction théorique du coût de requête de O(n) à O(log n) pour les recherches ciblées.

## 5. Prochaines Étapes
- Intégrer un outil de BI (Tableau/PowerBI) pour visualiser ces données.
- Automatiser le pipeline ETL avec Apache Airflow.
