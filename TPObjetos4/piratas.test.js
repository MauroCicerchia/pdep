const piratas = require("./piratas")

var navegante = new piratas.Navegante(10, 50);
var cocinero = new piratas.Cocinero(["Atun"], 50, 100);
var guerrero = new piratas.Guerrero(100, 40);
var jackSparrow = piratas.jackSparrow;

describe("Poder de Mando", () => {
    it("El poder de mando de un navegante con 10 de inteligencia deberia ser 100", () => {
        expect(navegante.poderDeMando()).toEqual(100);
    });
    
    it("El poder de mando de un cocinero con 50 de moral y 1 ingrediente deberia ser 50", () => {
        expect(cocinero.poderDeMando()).toEqual(50);
    });
    
    it("El poder de mando de un guerrero con 100 de vitalidad y 40 de poder de pelea deberia ser 4000", () => {
        expect(guerrero.poderDeMando()).toEqual(4000);
    });
    
    it("El poder de mando de jack sparrow deberia ser 30000000", () => {
        expect(jackSparrow.poderDeMando()).toEqual(30000000);
    });
});

describe("Beber Ron", () => {
    beforeAll(() => {
        jackSparrow.beberRonCon(cocinero);
    });

    it("Si jack toma ron con el cocinero, la energia de jack deberia ser 600", () => {
        expect(jackSparrow.energia).toEqual(600);
    });
    
    it("Si jack toma ron con el cocinero, la energia del cocinero deberia ser 50", () => {
        expect(cocinero.energia).toEqual(50);
    });

    it("Si jack toma ron con el cocinero, el cocinero deberia quedarse sin ingredientes", () => {
        expect(cocinero.ingredientes).toEqual([]);
    });

    it("Si jack toma ron con el cocinero, jack deberia tenes una botella de ron y atun en sus ingredientes", () => {
        expect(jackSparrow.ingredientes).toEqual(["Botella de ron", "Atun"]);
    });
});