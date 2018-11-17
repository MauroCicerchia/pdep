const bandos = require("./bandos")
const piratas = require("./piratas")

const armadaInglesa = bandos.armadaInglesa;
const unionPirata = bandos.unionPirata;
const armadaDelHE = bandos.armadaDelHE;
const ninguno = bandos.ninguno;
const juan = new piratas.Pirata();

describe("Armada Inglesa", () => {
    it("Si un barco de la armada inglesa tenia 30 de municion, ahora deberia tener 39", () => {
        expect(armadaInglesa.municionTotal(30)).toEqual(39);
    });

    it("Si un barco de la armada inglesa tenia 100 de poderDeFuego, deberia seguir igual", () => {
        expect(armadaInglesa.poderDeFuegoTotal(100)).toEqual(100);
    });

    it("Si un barco de la armada inglesa tenia a juan como tripulante, deberia seguir igual", () => {
        expect(armadaInglesa.tripulacionTotal([juan])).toEqual([juan]);
    });
});

describe("Union Pirata", () => {
    it("Si un barco de la union pirata tenia 30 de municion, deberia seguir igual", () => {
        expect(unionPirata.municionTotal(30)).toEqual(30);
    });

    it("Si un barco de la union pirata tenia 100 de poderDeFuego, ahora deberia tener 160", () => {
        expect(unionPirata.poderDeFuegoTotal(100)).toEqual(160);
    });

    it("Si un barco de la union pirata tenia a juan como tripulante, deberia seguir igual", () => {
        expect(unionPirata.tripulacionTotal([juan])).toEqual([juan]);
    });
});

describe("Armada del Holandes Errante", () => {
    it("Si un barco de la armada del Holandes Errante tenia 30 de municion, deberia seguir igual", () => {
        expect(armadaDelHE.municionTotal(30)).toEqual(30);
    });

    it("Si un barco de la armada del Holandes Errante tenia 100 de poderDeFuego, deberia seguir igual", () => {
        expect(armadaDelHE.poderDeFuegoTotal(100)).toEqual(100);
    });

    it("Si un barco de la armada del Holandes Errante tenia a juan como tripulante, ahora deberia tenerlo dos veces", () => {
        expect(armadaDelHE.tripulacionTotal([juan])).toEqual([juan, juan]);
    });
});

describe("Ningun Bando", () => {
    it("Si un barco sin bando tenia 30 de municion, deberia seguir igual", () => {
        expect(ninguno.municionTotal(30)).toEqual(30);
    });

    it("Si un barco sin bando tenia 100 de poderDeFuego, deberia seguir igual", () => {
        expect(ninguno.poderDeFuegoTotal(100)).toEqual(100);
    });

    it("Si un barco sin bando tenia a juan como tripulante, deberia seguir igual", () => {
        expect(ninguno.tripulacionTotal([juan])).toEqual([juan]);
    });
});