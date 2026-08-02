// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FreelanceEscrow {
    // Definisanje ucesnika u ugovoru
    address public klijent;
    address payable public frilenser;
    address public arbitar;
    
    uint256 public iznosPosla;

    //State Machine ugovora
    enum Stanje { POKRENUT, DEPONOVANO, ZAVRSENO, VRACENO }
    Stanje public trenutnoStanje;

    // Modifikatori za ogranicenje prava pristupa
    modifier samoKlijent() {
        require(msg.sender == klijent, "Samo klijent moze pozvati ovu funkciju.");
        _;
    }

    modifier samoArbitar() {
        require(msg.sender == arbitar, "Samo arbitar moze doneti odluku.");
        _;
    }

    modifier uStanju(Stanje _stanje) {
        require(trenutnoStanje == _stanje, "Neispravno stanje ugovora za ovu akciju.");
        _;
    }

    // Inicijalizacija ugovora (Constructor)
    constructor(address payable _frilenser, address _arbitar) {
        klijent = msg.sender; // Onaj ko postavi ugovor (deploy) je klijent
        frilenser = _frilenser;
        arbitar = _arbitar;
        trenutnoStanje = Stanje.POKRENUT;
    }

    // KORAK 1: Klijent deponuje sredstva u ugovor
    function deponujSredstva() external payable samoKlijent uStanju(Stanje.POKRENUT) {
        require(msg.value > 0, "Iznos mora biti veci od 0.");
        iznosPosla = msg.value;
        trenutnoStanje = Stanje.DEPONOVANO;
    }

    // KORAK 2: Klijent je zadovoljan radom i oslobadja sredstva frilenseru
    function potvrdiZavrsetakPosla() external samoKlijent uStanju(Stanje.DEPONOVANO) {
        trenutnoStanje = Stanje.ZAVRSENO;
        
        // NOVI NACIN TRANSFERA
        (bool uspesno, ) = frilenser.call{value: iznosPosla}("");
        require(uspesno, "Transfer frilenseru nije uspeo.");
    }

    // KORAK 3: Rešavanje spora (poziva samo Arbitar)
    function resiSpor(bool _uKoristKlijenta) external samoArbitar uStanju(Stanje.DEPONOVANO) {
        if (_uKoristKlijenta) {
            // Ako je klijent u pravu, novac se vraca njemu
            trenutnoStanje = Stanje.VRACENO;
            
            // NOVI NACIN TRANSFERA
            (bool uspesno, ) = payable(klijent).call{value: iznosPosla}("");
            require(uspesno, "Povracaj klijentu nije uspeo.");
        } else {
            // Ako je frilenser u pravu, isplacuje mu se novac
            trenutnoStanje = Stanje.ZAVRSENO;
            
            // NOVI NACIN TRANSFERA
            (bool uspesno, ) = frilenser.call{value: iznosPosla}("");
            require(uspesno, "Transfer frilenseru nije uspeo.");
        }
    }
}