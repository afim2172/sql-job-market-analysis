# Rapport Final du Projet : Analyse du Marché de l'Emploi Data

*(English version below)*

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

---

# Final Project Report: Data Job Market Analysis

## 1. Project Objective
This project aimed to simulate a real-world Data Engineering environment to analyze job market trends in the data field (Data Analyst, Data Engineer, Data Scientist).
The goal was to answer strategic questions about salaries and demanded skills, while optimizing database performance.

## 2. Technical Architecture
- **Database**: PostgreSQL 15+
- **Schema**: Star Schema
  - `job_postings_fact` (Fact Table: 200+ postings)
  - `company_dim`, `skills_dim` (Dimensions)
  - `skills_job_dim` (Many-to-Many Link Table)
- **ETL**: Python (Pandas) for generation and cleaning, SQL (`COPY`) for loading.

## 3. Key Results and Insights
Following the SQL analysis, here are the major findings on this simulated dataset:
1.  **Top Roles**: **Senior Analytics Engineer** and **Data Architect** roles often dominate the salary rankings, sometimes surpassing pure Data Scientists.
2.  **Lucrative Skills**:
    - Specific cloud skills (e.g., **Snowflake**, **Databricks**) are correlated with higher salaries than generic skills (Excel).
    - **Python** and **SQL** remain the most in-demand skills (volume of postings), confirming their "must-have" status.
3.  **Remote Work**: "Remote" positions offer competitive salaries, often aligned with major tech markets (SF, NY) regardless of the candidate's location.

## 4. Performance Optimization
To prepare for scaling (Big Data), we optimized the queries:
- **Identified Problem**: Filtering queries used a `Seq Scan` (full table read), which is inefficient on large volumes.
- **Solution**: Creation of B-Tree indexes on frequent filtering columns:
  ```sql
  CREATE INDEX idx_job_title_short ON job_postings_fact(job_title_short);
  CREATE INDEX idx_salary_year_avg ON job_postings_fact(salary_year_avg);
  ```
- **Result**: Theoretical reduction of query cost from O(n) to O(log n) for targeted searches.

## 5. Next Steps
- Integrate a BI tool (Tableau/PowerBI) to visualize this data.
- Automate the ETL pipeline with Apache Airflow.
