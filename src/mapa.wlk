import wollok.game.*
import objetos.*
import personajes.*


object mapa {
	var property objetosEnMapa = []
	var property fuegosEnMapa= []

	method hayObstaculo(pos) = objetosEnMapa.any({o => o.position() == pos})
	method hayFuego(pos) = fuegosEnMapa.any({f => f.position() == pos})
	
	method agregarPosiciones() {
		objetosEnMapa.add(new Obstaculo(position=game.at(5,2)))
		objetosEnMapa.add(new Obstaculo(position=game.at(7,4)))
		objetosEnMapa.add(new Obstaculo(position=game.at(2,6)))
		objetosEnMapa.add(new Obstaculo(position=game.at(8,8)))
		objetosEnMapa.add(new Obstaculo(position=game.at(11,5)))
		objetosEnMapa.add(bombero)
	}
	
	method agregarFuego(obj) { fuegosEnMapa.add(obj) }
	method quitarFuego(obj) { fuegosEnMapa.remove(obj) }
}

