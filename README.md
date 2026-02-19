# Projet d'Ingénierie de Données SQL - Analyse du Marché de l'Emploi

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
