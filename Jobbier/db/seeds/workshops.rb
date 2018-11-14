
    cocina = File.open("#{File.dirname(__FILE__)}/images/workshops/cocina.jpg")
    cocina2 = File.open("#{File.dirname(__FILE__)}/images/workshops/cocina2.png")
    cocina3 = File.open("#{File.dirname(__FILE__)}/images/workshops/cocina3.jpg")
    cocina4 = File.open("#{File.dirname(__FILE__)}/images/workshops/cocina4.jpg")

    madera = File.open("#{File.dirname(__FILE__)}/images/workshops/madera.jpeg")
    madera2 = File.open("#{File.dirname(__FILE__)}/images/workshops/madera2.jpg")
    madera3 = File.open("#{File.dirname(__FILE__)}/images/workshops/madera3.jpg")
    madera4 = File.open("#{File.dirname(__FILE__)}/images/workshops/madera4.jpg")

    mecanica = File.open("#{File.dirname(__FILE__)}/images/workshops/mecanica.jpg")
    mecanica2 = File.open("#{File.dirname(__FILE__)}/images/workshops/mecanica2.jpg")
    mecanica3 = File.open("#{File.dirname(__FILE__)}/images/workshops/mecanica3.jpg")
    mecanica4 = File.open("#{File.dirname(__FILE__)}/images/workshops/mecanica4.jpg")

    musica = File.open("#{File.dirname(__FILE__)}/images/workshops/musica.jpg")
    musica2 = File.open("#{File.dirname(__FILE__)}/images/workshops/musica2.jpg")
    musica3 = File.open("#{File.dirname(__FILE__)}/images/workshops/musica3.jpg")
    musica4 = File.open("#{File.dirname(__FILE__)}/images/workshops/musica4.jpg")



    musica = File.open("#{File.dirname(__FILE__)}/images/workshops/musica.jpg")
    musica2 = File.open("#{File.dirname(__FILE__)}/images/workshops/musica2.jpg")
    musica3 = File.open("#{File.dirname(__FILE__)}/images/workshops/musica3.jpg")
    musica4 = File.open("#{File.dirname(__FILE__)}/images/workshops/musica4.jpg")


    futbol = File.open("#{File.dirname(__FILE__)}/images/workshops/futbol.jpg")
    futbol2 = File.open("#{File.dirname(__FILE__)}/images/workshops/futbol2.jpg")
    futbol3 = File.open("#{File.dirname(__FILE__)}/images/workshops/futbol3.jpg")

    literatura = File.open("#{File.dirname(__FILE__)}/images/workshops/literatura.jpg")
    literatura2 = File.open("#{File.dirname(__FILE__)}/images/workshops/literatura2.jpg")
    literatura3 = File.open("#{File.dirname(__FILE__)}/images/workshops/literatura3.jpg")

    teatro = File.open("#{File.dirname(__FILE__)}/images/workshops/teatro.jpg")
    teatro2 = File.open("#{File.dirname(__FILE__)}/images/workshops/teatro2.jpg")
    teatro3 = File.open("#{File.dirname(__FILE__)}/images/workshops/teatro3.jpg")









    cat1 = WorkshopCategory.find_by(name: 'Gastronomía')
    cat2 = WorkshopCategory.find_by(name: 'Música')
    cat3 = WorkshopCategory.find_by(name: 'Oficios')
    cat4 = WorkshopCategory.find_by(name: 'Artes')
    cat5 = WorkshopCategory.find_by(name: 'Deportes')
    cat6 = WorkshopCategory.find_by(name: 'Otros')



    country = Country.find_by(name: 'Argentina')
    province = Province.find_by(name: 'Buenos Aires')
    city = City.find_by(name: 'La Plata')
    city2 = City.find_by(name: '9 DE JULIO')
    city3 = City.find_by(name: 'MAR DEL PLATA')

    Workshop.create(
        normal_profile_id: 1,
        activity_title: "Taller de Cocina",
        activity_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a nibh velit. Nulla ante libero",
        workshop_images: [
            WorkshopImage.new(
                kind: :place,
                image: Image.new(file: cocina)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: cocina2)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: cocina3)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: cocina4)
            ),
        ],
        country: country,
        province: province,
        city: city,
        workshop_category: cat1,
        place: :casa, #  :omitir     :institucion    :casa    :aire_libre    :a_domicilio
        description_place: 'Cras ultrices magna eget mattis ornare. Duis tempor tellus mi',
        street: '44',
        number: '1122',
        floor: '',
        apartment: '',
        latitude: '-34.916884',
        longitude: '-57.961911',
        gender: :male, #    :female    :other
        age_min: '1',
        age_max: '100',
        level: :beginners, #    :medium,    :advanced
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a',
        workshop_schedules: [
            WorkshopSchedule.new(
                schedule_info: 'Martes y Jueves de 8 a 10',
                maximun_quota: '20',
                unlimited_quota: false,
                start_publication: (Date.today - 3.day),
                always_open: false,
                closing_of_registrations: (Date.today + 50.day),
                never_close: false
            )
        ],
        things_included: 'Todos los materiales',
        things_to_carry: 'Nada',
        aspects_to_consider: 'Buena onda',
        price: 300,
        state: :open #    :draft
    )




    Workshop.create(
        normal_profile_id: 2,
        activity_title: "Taller de Carpintería",
        activity_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a nibh velit. Nulla ante libero",
        workshop_images: [
            WorkshopImage.new(
                kind: :place,
                image: Image.new(file: madera)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: madera2)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: madera3)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: madera4)
            ),
        ],
        country: country,
        province: province,
        city: city,
        workshop_category: cat3,
        place: :casa, #  :omitir     :institucion    :casa    :aire_libre    :a_domicilio
        description_place: 'Cras ultrices magna eget mattis ornare. Duis tempor tellus mi',
        street: '44',
        number: '1122',
        floor: '',
        apartment: '',
        latitude: '-34.921406',
        longitude: '-57.966953',
        gender: :male, #    :female    :other
        age_min: '1',
        age_max: '100',
        level: :beginners, #    :medium,    :advanced
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a',
        workshop_schedules: [
            WorkshopSchedule.new(
                schedule_info: 'Martes y Jueves de 8 a 10',
                maximun_quota: '20',
                unlimited_quota: false,
                start_publication: (Date.today - 3.day),
                always_open: false,
                closing_of_registrations: (Date.today + 50.day),
                never_close: false
            )
        ],
        things_included: 'Todos los materiales',
        things_to_carry: 'Nada',
        aspects_to_consider: 'Buena onda',
        price: 760,
        state: :open #    :draft
    )





    Workshop.create(
        normal_profile_id: 3,
        activity_title: "Taller de Mecánica",
        activity_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a nibh velit. Nulla ante libero",
        workshop_images: [
            WorkshopImage.new(
                kind: :place,
                image: Image.new(file: mecanica)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: mecanica2)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: mecanica3)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: mecanica4)
            ),
        ],
        country: country,
        province: province,
        city: city,
        workshop_category: cat3,
        place: :casa, #  :omitir     :institucion    :casa    :aire_libre    :a_domicilio
        description_place: 'Cras ultrices magna eget mattis ornare. Duis tempor tellus mi',
        street: '44',
        number: '1122',
        floor: '',
        apartment: '',
        latitude: '-34.912948',
        longitude: '-57.966087',
        gender: :male, #    :female    :other
        age_min: '1',
        age_max: '100',
        level: :beginners, #    :medium,    :advanced
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a',
        workshop_schedules: [
            WorkshopSchedule.new(
                schedule_info: 'Lunes a las 20:00 hs',
                maximun_quota: '20',
                unlimited_quota: false,
                start_publication: (Date.today + 2.day),
                always_open: false,
                never_close: true
            )
        ],
        things_included: 'Todos los materiales',
        things_to_carry: 'Nada',
        aspects_to_consider: 'Buena onda',
        price: 1300,
        state: :open #    :draft
    )




     Workshop.create(
         normal_profile_id: 4,
         activity_title: "Taller de Música",
         activity_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a nibh velit. Nulla ante libero",
         workshop_images: [
             WorkshopImage.new(
                 kind: :place,
                 image: Image.new(file: musica)
             ),
             WorkshopImage.new(
                 kind: :normal,
                 image: Image.new(file: musica2)
             ),
             WorkshopImage.new(
                 kind: :normal,
                 image: Image.new(file: musica3)
             ),
             WorkshopImage.new(
                 kind: :normal,
                 image: Image.new(file: musica4)
             ),
         ],
         country: country,
         province: province,
         city: city,
         workshop_category: cat2,
         place: :casa, #  :omitir     :institucion    :casa    :aire_libre    :a_domicilio
         description_place: 'Cras ultrices magna eget mattis ornare. Duis tempor tellus mi',
         street: '44',
         number: '1122',
         floor: '',
         apartment: '',
         latitude: '-34.910811',
         longitude: '-57.968910',
         gender: :male, #    :female    :other
         age_min: '1',
         age_max: '100',
         level: :beginners, #    :medium,    :advanced
         description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a',
         workshop_schedules: [
             WorkshopSchedule.new(
                 schedule_info: 'Domingos a las 6 am',
                 maximun_quota: '20',
                 unlimited_quota: false,
                 always_open: true,
                 never_close: true
             )
         ],
         things_included: 'Todos los materiales',
         things_to_carry: 'Nada',
         aspects_to_consider: 'Buena onda',
         price: 500,
         state: :open #    :draft
     )








    Workshop.create(
        normal_profile_id: 1,
        activity_title: "Taller de Futbol",
        activity_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a nibh velit. Nulla ante libero",
        workshop_images: [
            WorkshopImage.new(
                kind: :place,
                image: Image.new(file: futbol)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: futbol2)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: futbol3)
            )
        ],
        country: country,
        province: province,
        city: city3,
        workshop_category: cat5,
        place: :omitir, #  :omitir     :institucion    :casa    :aire_libre    :a_domicilio
        description_place: 'Cras ultrices magna eget mattis ornare. Duis tempor tellus mi',
        gender: :male, #    :female    :other
        age_min: '1',
        age_max: '100',
        level: :beginners, #    :medium,    :advanced
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a',
        workshop_schedules: [
            WorkshopSchedule.new(
                schedule_info: 'Martes y Jueves de 8 a 10',
                maximun_quota: '10',
                unlimited_quota: false,
                start_publication: (Date.today + 20.day),
                always_open: false,
                closing_of_registrations: (Date.today + 50.day),
                never_close: false
            )
        ],
        things_included: 'Todos los materiales',
        things_to_carry: 'Nada',
        aspects_to_consider: 'Buena onda',
        price: 300,
        state: :open #    :draft
    )


    Workshop.create(
        normal_profile_id: 2,
        activity_title: "Taller de Literatura",
        activity_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a nibh velit. Nulla ante libero",
        workshop_images: [
            WorkshopImage.new(
                kind: :place,
                image: Image.new(file: literatura)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: literatura2)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: literatura3)
            )
        ],
        country: country,
        province: province,
        city: city2,
        workshop_category: cat6,
        place: :a_domicilio, #  :omitir     :institucion    :casa    :aire_libre    :a_domicilio
        description_place: 'Cras ultrices magna eget mattis ornare. Duis tempor tellus mi',
        gender: :male, #    :female    :other
        age_min: '1',
        age_max: '100',
        level: :beginners, #    :medium,    :advanced
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a',
        workshop_schedules: [
            WorkshopSchedule.new(
                schedule_info: 'Martes y Jueves de 8 a 10',
                maximun_quota: '30',
                unlimited_quota: false,
                start_publication: (Date.today + 20.day),
                always_open: false,
                closing_of_registrations: (Date.today + 50.day),
                never_close: false
            ),
            WorkshopSchedule.new(
                schedule_info: 'Martes y Jueves de 15 a 17',
                maximun_quota: '20',
                unlimited_quota: false,
                start_publication: (Date.today + 10.day),
                always_open: false,
                closing_of_registrations: (Date.today + 20.day),
                never_close: false
            )
        ],
        things_included: 'Todos los materiales',
        things_to_carry: 'Nada',
        aspects_to_consider: 'Buena onda',
        price: 300,
        state: :open #    :draft
    )


    Workshop.create(
        normal_profile_id: 1,
        activity_title: "Taller de Teatro",
        activity_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a nibh velit. Nulla ante libero",
        workshop_images: [
            WorkshopImage.new(
                kind: :place,
                image: Image.new(file: teatro)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: teatro2)
            ),
            WorkshopImage.new(
                kind: :normal,
                image: Image.new(file: teatro3)
            )
        ],
        country: country,
        province: province,
        city: city,
        workshop_category: cat4,
        place: :casa, #  :omitir     :institucion    :casa    :aire_libre    :a_domicilio
        description_place: 'Cras ultrices magna eget mattis ornare. Duis tempor tellus mi',
        street: '44',
        number: '1122',
        floor: '',
        apartment: '',
        latitude: '-34.916884',
        longitude: '-57.966087',
        gender: :male, #    :female    :other
        age_min: '1',
        age_max: '100',
        level: :beginners, #    :medium,    :advanced
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices magna eget mattis ornare. Duis tempor tellus mi, eu commodo leo rhoncus ut. Donec a',
        workshop_schedules: [
            WorkshopSchedule.new(
                schedule_info: 'Martes y Jueves de 8 a 10',
                unlimited_quota: true,
                start_publication: (Date.today + 20.day),
                always_open: false,
                closing_of_registrations: (Date.today + 50.day),
                never_close: false
            ),
            WorkshopSchedule.new(
                schedule_info: 'Martes y Jueves de 16 a 18',
                unlimited_quota: true,
                start_publication: (Date.today + 20.day),
                always_open: false,
                closing_of_registrations: (Date.today + 50.day),
                never_close: false
            )
        ],
        things_included: 'Todos los materiales',
        things_to_carry: 'Nada',
        aspects_to_consider: 'Buena onda',
        price: 300,
        state: :open #    :draft
    )


    WorkshopStep.update_all(ok: true)
