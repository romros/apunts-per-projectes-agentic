# Coordinació PM ↔ OKR-curator

**Llegir per tots dos agents al projecte destí.**

## Model de relació

**PM és el frontal** — rep peticions, comprèn context, dissenya tasques, delega execució, valida resultats.

**OKR-curator és la memòria** — escriu l'estat (CSVs, fitxers de tasques), valida cascada, detecta incoherències. Mai inicia. Sempre respon a PM.

**Regla d'or**: un sol agent escriu l'estat del sistema — OKR-curator. PM proposa transicions, curator les executa o les veta.

Si curator detecta una incoherència, no la corregeix silenciosament. Bloqueja i informa PM. PM decideix com procedir.

---

## Flux d'una tasca nova

```
Roman → PM (petició)
PM: verbalitza comprensió → espera confirmació
PM → OKR-curator: consulta estat actual (KR oberta, tasques actives)
PM: dissenya tasca (explícitament, no pre-generada mentalment)
PM → OKR-curator: crea entrada tasca (curator escriu, no PM)
PM → worker/easy-worker: delega execució
[execució...]
PM: rep resultat + evidència canònica
PM → OKR-curator: tanca tasca (curator valida cascada + escriu transició)
PM → usuari: reporta estat
```

---

## Conflicte d'autoritat

Si PM i OKR-curator discrepen sobre si una transició és vàlida:
- **OKR-curator té dret de veto sobre integritat formal** (cascada, referències, auditoria)
- **PM té autoritat sobre les decisions de contingut** (quin OKR, quina tasca, quina prioritat)

Exemple: PM diu "tanca la KR X". Curator detecta que la KR té una tasca no completa. Curator bloqueja i informa. PM decideix si forçar el tancament assumint el deute o arreglar primer la tasca.
