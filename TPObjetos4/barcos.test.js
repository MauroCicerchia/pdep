const piratas = require("./piratas");
const barcos = require("./barcos");
const bandos = require("./bandos");

var jackSparrow = piratas.jackSparrow;
var willTurner = new piratas.Guerrero(200, 100, 300);
var davyJones = new piratas.MonstruoHumanoide(100000, 1000);
var bootstrapBill = new piratas.MonstruoHumanoide(20, 15);
const unionPirata = bandos.unionPirata;
const armadaDelHE = bandos.armadaDelHE;
var perlaNegra = new barcos.Barco(100, 100, 100, unionPirata, [jackSparrow, willTurner]);
var holandesErrante = new barcos.Barco(100, 100, 100, armadaDelHE, [davyJones, bootstrapBill]);

describe("Capitanes", () => {
    it("El capitan del perla negra deberia ser jack sparrow", () => {
        expect(perlaNegra.capitan()).toBe(jackSparrow);
    });

    it("El capitan del holandes errante deberia ser davy jones", () => {
        expect(holandesErrante.capitan()).toBe(davyJones);
    });
});

describe("Pelea de Barcos", () => {
    beforeAll(() => {
        perlaNegra.pelearCon(holandesErrante);
    });

    it("Luego de pelear con el holandes errante, el perla negra deberia tener a davy jones en su tripulacion", () => {
        expect(perlaNegra.tieneTripulante(davyJones)).toBeTruthy();
    });

    it("Luego de pelear con el perla negra, el holandes errante deberia estar desolado", () => {
        expect(holandesErrante.estaDesolado()).toBeTruthy();
    });

    it("Luego de pelear con el perla negra, davy jones deberia tener 50000 de poder de mando", () => {
        expect(davyJones.poderDeMando()).toEqual(50000);
    });
});

describe("Canionazos", () => {
    beforeAll(() => {
        perlaNegra.dispararCanionazos(30, holandesErrante);
    });

    it("Luego de disparar, la municion del perla negra deberia ser 70", () => {
        expect(perlaNegra.municion).toEqual(70);
    });

    it("Luego de recibir los disparos, la resistencia del holandes errante deberia ser 0", () => {
        expect(holandesErrante.resistencia).toEqual(0);
    });

    it("Luego de recibir los disparos, bootstrap bill no deberia seguir siendo tripulante del holandes errante", () => {
        expect(holandesErrante.tieneTripulante(bootstrapBill)).toBeFalsy();
    });

    it("Si el holandes errante intenta vengarse disparando 200 canionazos, no deberia poder", () => {
        expect(() => {holandesErrante.dispararCanionazos(200, perlaNegra)}).toThrowError("No se dispone de municion suficiente");
    });
});