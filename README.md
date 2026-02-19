# Projet d'Ingénierie de Données SQL - Analyse du Marché de l'Emploi

*(English version below)*

Ce projet est conçu pour analyser les tendances du marché de l'emploi en utilisant des données sur les offres d'emploi, les entreprises et les compétences. Inspiré par le cours de Luke Barousse.

## Structure du Projet

- **Base de Données**: PostgreSQL
- **Outils**: SQL, Python (optionnel pour l'ETL)
- **Objectif**: Analyser les salaires, la demande de compétences et la croissance des rôles.

## Plan d'Action (Phases)

### Phase 1 : Design du Schéma
- Création des tables normalisées pour éviter la redondance.
- Définition des clés primaires et étrangères.
- Tables créées : `company_dim`, `skills_dim`, `job_postings_fact`, `skills_job_dim`.
- **Statut**: *Fait (voir `sql_project/1_create_tables.sql`)*

### Phase 2 : Importation (ETL)
- **Objectif**: Charger les données brutes (JSON/CSV) dans la base de données.
- **Action**: Scripts Python de génération de données et SQL de chargement exécutés.
- **Statut**: *Fait (voir `sql_project/2_generate_data.py` et `3_load_data.sql`)*

### Phase 3 : Analyse SQL
- **Objectif**: Répondre aux questions business.
- **Questions Clés**:
  1. Top Jobs (Data Engineer télétravail).
  2. Compétences Top Jobs.
  3. Demande Globale.
  4. Salaire par Compétence.
  5. Compétence "Optimale".
- **Statut**: *Fait (voir `sql_project/5_analysis_queries.sql`)*

### Phase 4 : Optimisation
- **Objectif**: Améliorer la performance des requêtes SQL.
- **Techniques**:
  - `EXPLAIN ANALYZE` pour identifier les goulots d'étranglement (Seq Scan).
  - Création d'index (`CREATE INDEX`).
- **Statut**: *En cours (voir `sql_project/6_optimizations.sql`)*

## Instructions

1. Exécutez le script SQL `sql_project/1_create_tables.sql` pour créer la structure de la base de données.
2. Procédez à l'importation des données (Phase 2).
3. Lancez les requêtes d'analyse (Phase 3).

---

# SQL Data Engineering Project - Job Market Analysis

This project is designed to analyze job market trends using data on job postings, companies, and skills. Inspired by Luke Barousse's course.

## Project Structure

- **Database**: PostgreSQL
- **Tools**: SQL, Python (optional for ETL)
- **Objective**: Analyze salaries, skill demand, and role growth.

## Action Plan (Phases)

### Phase 1: Schema Design
- Creation of normalized tables to avoid redundancy.
- Definition of primary and foreign keys.
- Created tables: `company_dim`, `skills_dim`, `job_postings_fact`, `skills_job_dim`.
- **Status**: *Done (see `sql_project/1_create_tables.sql`)*

### Phase 2: Import (ETL)
- **Objective**: Load raw data (JSON/CSV) into the database.
- **Action**: Python data generation scripts and SQL loading scripts executed.
- **Status**: *Done (see `sql_project/2_generate_data.py` and `3_load_data.sql`)*

### Phase 3: SQL Analysis
- **Objective**: Answer business questions.
- **Key Questions**:
  1. Top Jobs (Remote Data Engineer).
  2. Skills for Top Jobs.
  3. Global Demand.
  4. Salary by Skill.
  5. "Optimal" Skill.
- **Status**: *Done (see `sql_project/5_analysis_queries.sql`)*

### Phase 4: Optimization
- **Objective**: Improve SQL query performance.
- **Techniques**:
  - `EXPLAIN ANALYZE` to identify bottlenecks (Seq Scan).
  - Creation of indexes (`CREATE INDEX`).
- **Status**: *In Progress (see `sql_project/6_optimizations.sql`)*

## Instructions

1. Run the SQL script `sql_project/1_create_tables.sql` to create the database structure.
2. Proceed with data import (Phase 2).
3. Run the analysis queries (Phase 3).
