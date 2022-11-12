import wollok.game.*
import objetos.*
import personajes.*
import juego.*


object mapa {
	var property objetosEnMapa = []
	var property fuegosEnMapa= []

	method hayObstaculo(pos) = objetosEnMapa.any({o => o.position() == pos}) || objetosEnMapa.any({o => o.position() == pos}) 
	method hayFuego(pos) = fuegosEnMapa.any({f => f.position() == pos})
	
	method agregarPosicionesIniciales() {
		objetosEnMapa.add(bombero)
		objetosEnMapa.add(new Obstaculo(position=game.at(5,2)))
		objetosEnMapa.add(new Obstaculo(position=game.at(7,4)))
		objetosEnMapa.add(new Obstaculo(position=game.at(2,6)))
		objetosEnMapa.add(new Obstaculo(position=game.at(8,8)))
		objetosEnMapa.add(new Obstaculo(position=game.at(10,5)))
	}
	
	method agregarNuevosObstaculos() {
		5.times({ i=>
			objetosEnMapa.add(new Obstaculo( position=objetosEnMapa.get(i).expandir() ))
			game.addVisual(objetosEnMapa.last())
		})
		juego.aparecerObstaculo()
		game.sound("woodCrack.mp3").play()
		game.onTick(5000, "Aparece nuevo obstaculo", {juego.aparecerObstaculo() game.sound("woodCrack2.mp3").play()} )
	}
	
	method agregarFuego(obj) { fuegosEnMapa.add(obj) }
	method quitarFuego(obj) { fuegosEnMapa.remove(obj) }
	method agregarObstaculo(obj) { objetosEnMapa.add(obj) }
	method borrarTodo() {
		objetosEnMapa.clear()
		fuegosEnMapa.clear()
	}	
}


