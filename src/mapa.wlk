import wollok.game.*
import objetos.*
import personajes.*


object mapa {
	var property objetosEnMapa = []
	var property nuevosObjetos = []
	var property fuegosEnMapa= []

	method hayObstaculo(pos) = objetosEnMapa.any({o => o.position() == pos}) || nuevosObjetos.any({o => o.position() == pos}) 
	method hayFuego(pos) = fuegosEnMapa.any({f => f.position() == pos})
	
	method agregarPosicionesIniciales() {
		objetosEnMapa.add(new Obstaculo(position=game.at(5,2)))
		objetosEnMapa.add(new Obstaculo(position=game.at(7,4)))
		objetosEnMapa.add(new Obstaculo(position=game.at(2,6)))
		objetosEnMapa.add(new Obstaculo(position=game.at(8,8)))
		objetosEnMapa.add(new Obstaculo(position=game.at(11,5)))
		objetosEnMapa.add(bombero)
	}
	
	method agregarNuevosObstaculos() {
		self.agregarNuevasPosiciones()
		self.nuevosObjetos().forEach({o=>game.addVisual(o)})	
	}
	
	method agregarNuevasPosiciones() {
		nuevosObjetos.add(new Obstaculo(position=game.at(6,1)))
		nuevosObjetos.add(new Obstaculo(position=game.at(7,3)))
		nuevosObjetos.add(new Obstaculo(position=game.at(4,4)))
		nuevosObjetos.add(new Obstaculo(position=game.at(9,10)))
		nuevosObjetos.add(new Obstaculo(position=game.at(5,5)))
		nuevosObjetos.add(new Obstaculo(position=game.at(7,7)))
	}
	
	method agregarFuego(obj) { fuegosEnMapa.add(obj) }
	method quitarFuego(obj) { fuegosEnMapa.remove(obj) }
	method borrarTodo() {
		objetosEnMapa.clear()
		nuevosObjetos.clear()
		fuegosEnMapa.clear()
	}	
}


