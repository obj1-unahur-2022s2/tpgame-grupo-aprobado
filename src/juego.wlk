import wollok.game.*
import personajes.*

object juego {
	var juegoIniciado = false
	method iniciar() {
		game.addVisualIn(pantallaDeInicio,game.at(0,0))
		pantallaDeInicio.iniciarAnimacion()
		keyboard.space().onPressDo({self.empezar()})
	
		//Pantalla
		game.width(8)
		game.height(12)
		game.boardGround("edificio.png")
		game.title("Fire-Fighters")
		game.cellSize(60)
		
		//controles
		keyboard.up().onPressDo({bombero.subir()})
		keyboard.down().onPressDo({bombero.bajar()})
		keyboard.left().onPressDo({bombero.izquierda()})
		keyboard.right().onPressDo({bombero.derecha()})
		keyboard.enter().onPressDo({bombero.apagarVentana()})
	
	
		game.start()	}
		
		method empezar(){
		game.sound("comienzo.mp3")
		if (not juegoIniciado){
			game.removeVisual(pantallaDeInicio)
			juegoIniciado = true
			pantallaDeInicio.terminarAnimacion()
			
			personajesAparecen.rivalAtaca()
			personajesAparecen.personajePrincipalAparece()
			}
		}
}
object personajesAparecen {
	method rivalAtaca(){
		game.addVisual(rival)
		//game.onTick(2000, "movimiento", { rival.movete() })
	}
	method personajePrincipalAparece(){
		game.addVisualCharacter(bombero)	
	}
}


object pantallaDeInicio{
	var imagen = false
	method iniciarAnimacion(){
		game.onTick(250,"Animacion del menu",{self.cambiar()})	}
	method terminarAnimacion(){
		game.removeTickEvent("Animacion del menu") 		}
	method cambiar(){
		if(imagen)
			imagen = false
		else
			imagen = true	}
	method image() {
		if(imagen)
			return "inicio.png"
		else
			return "inicio1.png"
	}
}

