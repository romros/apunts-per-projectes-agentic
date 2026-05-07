```yaml
name: corrector-catala
version: 1.0.0
status: validat
origen: projecte domini .cat (consultoria de dades)
aporta_agents:
  - corrector-catala
```

# Servei: corrector-catala

Correcció lingüística de documents en català. Útil a qualsevol projecte que produeixi text en català — informes, documentació, posts, comunicació institucional.

## Quan activar

- El projecte produeix documents en català destinats a una audiència
- Hi ha un pas de revisió lingüística al pipeline de producció de contingut
- La qualitat lingüística és un requisit (institucional, editorial, acadèmic)

## Fitxers que aporta

| Fitxer | Rol |
|--------|-----|
| `agents/corrector-catala.md` | Agent de correcció lingüística |

## Dependències

**Requereix activat**: cap

**Llegeix de**: el document a corregir (path declarat per l'orquestrador)

**Escriu a**: `<document>_corregit.md` (o sobreescriu l'original si s'indica)

## Activació manual

1. Copiar `agents/corrector-catala.md` a `.claude/agents/corrector-catala.md` del projecte destí
2. Al `CLAUDE.md` del projecte, afegir a la secció d'agents actius:
   ```
   - corrector-catala — correcció lingüística catalana (latent, invocar al final del pipeline)
   ```
3. Declarar el registre esperat al brief estàndard del projecte (formal / divulgatiu / institucional / literari)

## Notes

- **No té memòria persistent** — cada invocació és independent. El context de cada sessió el porta l'orquestrador.
- **Registre esperat obligatori**: sense registre declarat, l'agent l'infereix i és font d'error. Formalitzar-lo al brief del projecte.
- **Independència de pipeline**: pot invocar-se sol (un document qualsevol) o com a últim pas d'un pipeline multi-agent (ex: `equips/analisi-dades`, `equips/editorial`). En projectes editorials en català, és complementari al `corrector` editorial — cobreixen capes diferents: el corrector editorial verifica compliment de brief i coherència factual; el corrector-catala verifica normativa lingüística IEC. No es substitueixen.
- Quan s'usa dins de l'equip `analisi-dades`, rep el document final del redactor.
