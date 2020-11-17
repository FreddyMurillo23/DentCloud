class NegociosSearch{
   String rucnegocio;
   String nombrenegocio;
   String telefononegocio;
   String provincia;
   String canton;
   String direccionnegocio;
   String fotonegocio;

   NegociosSearch({
     this.rucnegocio='', 
     this.nombrenegocio, 
     this.telefononegocio='', 
     this.provincia='',
     this.canton = '',
     this.direccionnegocio = '',
     this.fotonegocio = '',    
    });

   factory NegociosSearch.fromJson(Map<String, dynamic> json) {
    return NegociosSearch(
      rucnegocio:               json['ruc_negocio'],
      nombrenegocio:            json['nombre_negocio'],
      telefononegocio:          json['telefono_negocio'],
      provincia:                json['provincia'],
      canton:                   json['canton'],
      direccionnegocio:         json['direccion_negocio'],
      fotonegocio:              json['foto_negocio'],
    );
  }

 }