class Planta {
	const anioDeObtencion
	var altura
	
	method altura()= altura
	method horasDeSolQueTolera() // metodo abstracto
	method esFuerte(){return self.horasDeSolQueTolera()  > 10}
	
	method daSemillas(){
		return self.esFuerte() or self.condicionAlternativa()
	}
	method condicionAlternativa() // metodo abstracto
	
	method espacioQueOcupa()
	
	method laParcelaEsIdeal(unaParcela)
}

class Menta inherits Planta{
	override method horasDeSolQueTolera()=6
	override method condicionAlternativa(){return altura > 0.4}
	override method espacioQueOcupa(){return altura * 3}
	override method laParcelaEsIdeal(unaParcela){
		return unaParcela.superficie() > 6
	}
}

class Soja inherits Planta {
	override method horasDeSolQueTolera(){
		return if(altura < 0.5){6} 
			else if (altura.between(0.5,1)){7} 
			else {9}
	}
	override method condicionAlternativa(){
		return anioDeObtencion > 2007 and altura > 1
	}
	
	override method espacioQueOcupa(){return altura / 2}
	override method laParcelaEsIdeal(unaParcela){
		return unaParcela.cantidadDeSolueRecibe() == self.horasDeSolQueTolera()
	}	
	
	
}

class Quinoa inherits Planta{
	var horasDeSolQueTolera
	
	override method horasDeSolQueTolera()=horasDeSolQueTolera
	override method espacioQueOcupa() = 0.5
	override method condicionAlternativa(){return anioDeObtencion < 2005}
	override method laParcelaEsIdeal(unaParcela){
		return not unaParcela.plantas().any({p=> p.altura() > 1.5})
	}		

}

class SojaTransgenica inherits Soja {
	
	override method daSemillas() = false
	
	override method laParcelaEsIdeal(unaParcela){
		return not (unaParcela.plantas().size() > 1)
	}
}

class Hierbabuena inherits Menta {
	override method espacioQueOcupa() = 2 * super() 
}

class Parcelas {
	var ancho
	var largo
	var horasDeSolQueRecibe
	const plantas=[]
	
	method plantas()=plantas
	
	method superficie() = ancho * largo
	
	method cantidadMaximaDePlantas(){
		return if(largo > ancho) self.superficie()/5 else self.superficie()/3 + largo
	}
	
	method tieneComplicaciones() = plantas.any({p=> p.horasDeSolQueTolera() < horasDeSolQueRecibe })
	
	method sePuedePlantar(unaPlanta){
		return plantas.size()< self.cantidadMaximaDePlantas() and unaPlanta.horasDeSolQueTolera() <= (horasDeSolQueRecibe - 2)
	}
	
	method plantar(unaPlanta){
		if (self.sePuedePlantar(unaPlanta))
			 plantas.add(unaPlanta)
		 else self.error("No puede plantarse esta planta")
	} 
	method seAsociaBien(unaPlanta)
	
	method porcentajeDePlantasBienAsociadas(){
		return plantas.count({p=> self.seAsociaBien(p)})/plantas.size() * 100
	}
	
}


class ParcelasEcologicas inherits Parcelas {
	override method seAsociaBien(unaPlanta) {
		return not self.tieneComplicaciones() and unaPlanta.laParcelaEsIdeal(self)
	}
}

class ParcelaIndustriales inherits Parcelas {
	override method seAsociaBien(unaPlanta) {
		return  self.plantas().size() <3  and unaPlanta.esFuerte()
	}
}

object inta {
	const parcelas =[]
	method promedioDePlantasPorParcela(){
		return parcelas.map({p=>p.plantas().size()}).sum()/parcelas.size()
	}
	
	method  parcelaMasAutosustentable(){
		return parcelas.filter({p=>p.plantas().size()> 4 }).max({p=>p.porcentajeDePlantasBienAsociadas() })
	}
	
}