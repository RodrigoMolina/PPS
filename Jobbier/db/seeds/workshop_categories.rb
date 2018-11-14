
#Artes
artesCard = File.open("#{File.dirname(__FILE__)}/images/cards/artes.png")
artesCover = File.open("#{File.dirname(__FILE__)}/images/covers/artes.png")
#Tecnología
tecnologíaCard = File.open("#{File.dirname(__FILE__)}/images/cards/tecnologia.png")
tecnologíaCover = File.open("#{File.dirname(__FILE__)}/images/covers/tecnologia.png")
#Idiomas
idiomasCard = File.open("#{File.dirname(__FILE__)}/images/cards/idiomas.png")
idiomasCover = File.open("#{File.dirname(__FILE__)}/images/covers/idiomas.png")
#Bienestar
bienestarCard = File.open("#{File.dirname(__FILE__)}/images/cards/bienestar.png")
bienestarCover = File.open("#{File.dirname(__FILE__)}/images/covers/bienestar.png")
#Deportes
deportesCard = File.open("#{File.dirname(__FILE__)}/images/cards/deportes.png")
deportesCover = File.open("#{File.dirname(__FILE__)}/images/covers/deportes.png")
#Gastronomia
gastronomiaCard = File.open("#{File.dirname(__FILE__)}/images/cards/gastronomia.png")
gastronomiaCover = File.open("#{File.dirname(__FILE__)}/images/covers/gastronomia.png")
#Musica
musicaCard = File.open("#{File.dirname(__FILE__)}/images/cards/musica.png")
musicaCover = File.open("#{File.dirname(__FILE__)}/images/covers/musica.png")
#Oficios
oficiosCard = File.open("#{File.dirname(__FILE__)}/images/cards/oficios.png")
oficiosCover = File.open("#{File.dirname(__FILE__)}/images/covers/oficios.png")
#Otros
otrosCard = File.open("#{File.dirname(__FILE__)}/images/cards/otros.png")
otrosCover = File.open("#{File.dirname(__FILE__)}/images/covers/otros.png")

WorkshopCategory.create(name: 'Artes', image_card_category: Image.new(file: artesCard), image_cover: Image.new(file: artesCover))
WorkshopCategory.create(name: 'Tecnología', image_card_category: Image.new(file: tecnologíaCard), image_cover: Image.new(file: tecnologíaCover))
WorkshopCategory.create(name: 'Idiomas', image_card_category: Image.new(file: idiomasCard), image_cover: Image.new(file: idiomasCover))
WorkshopCategory.create(name: 'Bienestar', image_card_category: Image.new(file: bienestarCard), image_cover: Image.new(file: bienestarCover))
WorkshopCategory.create(name: 'Deportes', image_card_category: Image.new(file: deportesCard), image_cover: Image.new(file: deportesCover))
WorkshopCategory.create(name: 'Gastronomía', image_card_category: Image.new(file: gastronomiaCard), image_cover: Image.new(file: gastronomiaCover))
WorkshopCategory.create(name: 'Música', image_card_category: Image.new(file: musicaCard), image_cover: Image.new(file: musicaCover))
WorkshopCategory.create(name: 'Oficios', image_card_category: Image.new(file: oficiosCard), image_cover: Image.new(file: oficiosCover))
WorkshopCategory.create(name: 'Otros', image_card_category: Image.new(file: otrosCard), image_cover: Image.new(file: otrosCover))
