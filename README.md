**"Automatizacija Escrow Plaćanja za Freelance Poslove"**. 
Projekat istražuje transformaciju frilens tržišta rada kroz primenu tehnologije blokčejna i pametnih ugovora, eliminišući potrebu za centralizovanim posrednicima (poput Upwork-a ili Fiverr-a). 

Sistem omogućava automatsko zaključavanje i distribuciju sredstava (najčešće stabilnih novčića - *Stablecoins*) na osnovu unapred definisanih i nepromenljivih uslova, koristeći deterministički računarski kod.

## ✨ Ključne Funkcionalnosti
*   **Decentralizovani Escrow (Deponovanje):** Klijent bezbedno deponuje sredstva u pametni ugovor pre početka rada. Sredstva su alocirana na jedinstvenoj adresi pametnog ugovora i ne mogu se jednostrano povući.
*   **Automatska Isplata:** Nakon uspešnog završetka posla, klijent odobrava oslobađanje sredstava koja se trenutno prebacuju na novčanik frilensera, eliminišući višednevna bankarska čekanja.
*   **Rešavanje Sporova (Dispute Resolution):** Integracija sa protokolima decentralizovane arbitraže (kao što je Kleros) u slučaju neslaganja između klijenta i frilensera.
*   **Smanjenje Transakcionih Troškova:** Drastično smanjenje provizija u poređenju sa tradicionalnim platformama (troškovi su svedeni na osnovne *gas fee* takse mreže).

## 🛠️ Tehnologije i Alati
*   **Jezik:** Solidity (v0.8.0)
*   **Razvojno okruženje:** Remix IDE / Remix VM
*   **Mreža:** Ethereum / Polygon (EVM kompatibilne mreže)
*   **Arhitektura:** Koncept mašine stanja (*State Machine* sa stanjima: `POKRENUT`, `DEPONOVANO`, `ZAVRSENO`, `VRACENO`)
