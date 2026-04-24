# apunts-per-projectes-agentic

> Manual de bones pràctiques per a sistemes agentic Claude Code.  
> Per consultar, no per clonar.

---

## Què és

Un conjunt mínim de peces que pots portar al teu projecte i que germinen allà.

No és un framework. No és una eina d'instal·lació automàtica. És un conjunt de decisions destil·lades d'experiència real que et donen un punt de partida sòlid en lloc d'haver de reinventar-les.

La idea base: la majoria de projectes agentic fracassen perquè l'agent que decideix i l'agent que executa són el mateix. Sense una veu que aporti criteri independent, el sistema és ràpid però fràgil. Aquest manual dóna estructura per evitar-ho des del primer dia.

---

## Què conté

### Nucli — la Trinitat (obligatori)

Tres rols mínims que fan possible qualsevol projecte agentic:

| Rol | Funció |
|-----|--------|
| **Orquestrador** | Tradueix intenció en acció. Coordina, no decideix arquitectura. |
| **Worker** | Executa. Implementa les tasques que rep. |
| **Oracle** | Porta el criteri arquitectònic. Es convoca en moments crítics, no a cada cicle. |

Els tres rols no son jeràrquics — són complementaris. Sense oracle, el sistema no té criteri independent. Sense worker, les decisions no es materialitzen. Sense orquestrador, no hi ha pont entre els dos.

Veure `nucli/` per als fitxers d'agent base.

### Normes globals

Regles fundacionals aplicables a qualsevol projecte agentic, independentment del domini.

Veure `NORMES_GLOBALS.md`.

### Serveis modulars

Paquets autocontinguts que s'afegeixen quan el projecte els necessita:

| Servei | Quan activar-lo |
|--------|-----------------|
| **Memòria** | Sempre (la trinitat sense memòria és amnèsica) |
| **Docs** | Quan el projecte comença a tenir documentació que cal mantenir |
| **OKR** | Quan el projecte té objectius formals i un roadmap |
| **PM** | Quan el volum de tasques justifica metodologia estructurada |
| **Dev** | Quan hi ha codi i cal validació canònica |

Cada servei és independent i declara les seves dependències. Veure `serveis/`.

---

## Com s'usa

### Primer ús (bootstrap)

1. Copia `nucli/` al teu projecte.
2. Copia `NORMES_GLOBALS.md` i adapta les 2-3 línies de context específic del teu domini.
3. Activa el **Servei Memòria** (imprescindible des del dia 1).
4. Para. Treballa 2-3 setmanes. Observa quina fricció apareix.
5. Activa el servei que resol la fricció que has observat. No abans.

### Regla d'activació

> **Activa el mínim, observa la fricció, activa el següent.**

La temptació d'activar tots els serveis d'entrada és sobreenginyeria disfressada de modularitat. Un projecte que comença no necessita OKRs ni metodologia PM — necessita la trinitat i memòria. Res més fins que la fricció concreta no ho demani.

### Activació successiva

```bash
# Quan arribi la fricció que justifica un servei nou:
bash scripts/activate-service.sh <nom-servei>
```

El script copia els fitxers del servei, resol dependències transitives i actualitza el `CLAUDE.md` del teu projecte.

*(Script disponible a partir de Fase 4 del manual. Si el script no existeix encara, consulta `serveis/<nom>/MANIFEST.md` per activació manual.)*

---

## Origen

Destil·lat de **laboratori_profes**, un projecte real d'eina de correcció d'exàmens. Les normes i els serveis no s'han inventat — han sorgit de l'ús i s'han formalitzat quan han provat el seu valor.

Cap peça entra a aquest manual sense haver funcionat en un projecte real prèviament.

---

## Estructura del repo

```
MANIFEST.md          ← estàs aquí
NORMES_GLOBALS.md    ← les regles fundacionals
nucli/               ← orquestrador, worker, oracle (agents base)
serveis/             ← paquets modulars activables
scripts/             ← bootstrap i activate-service
```
