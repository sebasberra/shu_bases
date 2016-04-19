DELETE FROM diagnose_paciente_personas;

SELECT COUNT(*) FROM hc_personas;
SELECT COUNT(*) FROM personas;
SELECT COUNT(*) FROM `personas_diagnose_docs_inconsistentes`
WHERE id_efector=488;
SELECT COUNT(*) FROM `hc_personas_diagnose_diferentes`
WHERE id_efector=488;