CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    amount_in_stock INT NOT NULL,
    description TEXT,
    image_url VARCHAR(255)
);


INSERT INTO products (product_name, price, amount_in_stock, description, image_url) VALUES
('Zestaw stolik + krzesła czarne', 499.99, 10, 'Zestaw 2 krzesła + stolik, drewniane, czarne, w nowoczesnym stylu.', 'images/img-00001.jpg'),
('Komoda wielokolorowa drewniana', 849.99, 5, 'Solidna komoda z drewna z szafkami i szufladami, idealna do salonu.', 'images/img-00002.jpg'),
('Taboret barowy czerwony', 129.99, 18, 'Wysoki taboret z czerwonym siedziskiem, świetny do kuchni lub baru.', 'images/img-00003.jpg'),
('Stół duży drewniany ciemny', 1199.00, 4, 'Masywny stół w ciemnym kolorze drewna, elegancki i funkcjonalny.', 'images/img-00004.jpg'),
('Sofa szara składana', 899.00, 6, 'Wąska, rozkładana sofa w szarym kolorze, doskonała do mniejszych przestrzeni.', 'images/img-00005.jpg'),
('Krzesło drewniane białe', 149.99, 12, 'Lekkie, cienkie krzesło drewniane w białym kolorze, w prostym stylu.', 'images/img-00006.jpg'),
('Krzesło kolorowe małe', 89.99, 20, 'Niewielkie, wielobarwne krzesło, idealne do pokoju dziecięcego lub kreatywnej przestrzeni.', 'images/img-00007.jpg'),
('Lampa vintage żółta i niebieska', 219.99, 7, 'Stylowa lampa z żółtym abażurem i niebieską podstawą, w staromodnym stylu.', 'images/img-00008.jpg'),
('Fotel biurowy regulowany szary', 499.00, 9, 'Wygodny fotel do biura z regulacją wysokości, w odcieniu szarości.', 'images/img-00009.jpg'),
('Krzesło kawowe niebieskie', 169.99, 11, 'Komfortowe krzesło w intensywnym niebieskim kolorze, idealne do kącika kawowego.', 'images/img-00010.jpg'),
('Kanapa niebieska szeroka', 1399.00, 3, 'Przestronna kanapa w kolorze głębokiego niebieskiego, wygodna i stylowa.', 'images/img-00011.jpg'),
('Krzesło nowoczesne srebrne', 199.00, 10, 'Niewielkie, srebrne krzesło o nowoczesnym wyglądzie i smukłej konstrukcji.', 'images/img-00012.jpg'),
('Krzesło szare nowoczesne', 189.00, 8, 'Nowoczesne krzesło w odcieniu szarości, lekkie i wygodne.', 'images/img-00013.jpg'),
('Donica piaskowa', 89.99, 15, 'Estetyczna donica na kwiaty w kolorze piasku, pasująca do wnętrz i balkonów.', 'images/img-00014.jpg'),
('Półka drewniana biała', 139.99, 10, 'Biała półka na drewnianych podporach, praktyczna i stylowa.', 'images/img-00015.jpg'),
('Stolik kawowy niski brązowy', 299.00, 6, 'Niski stolik kawowy z ciemnego drewna, idealny do salonu.', 'images/img-00016.jpg'),
('Łóżko futurystyczne czarne', 1899.00, 2, 'Szerokie łóżko z czarnymi podporami w futurystycznym stylu, wygodne i designerskie.', 'images/img-00017.jpg'),
('Fotel biały ze wzorem', 599.99, 4, 'Drewniany, biały fotel w stylu retro, zdobiony eleganckimi wzorami.', 'images/img-00018.jpg'),
('Krzesło składane w kwiaty', 109.99, 14, 'Metalowe, składane krzesło z kwiatowym motywem, idealne na balkon.', 'images/img-00019.jpg'),
('Stolik kawowy czarny mały', 169.99, 10, 'Niewielki czarny stolik kawowy w nowoczesnej formie.', 'images/img-00020.jpg'),
('Kanapa drewniana biała', 749.99, 5, 'Lekka, drewniana kanapa w białym kolorze, idealna do przytulnych wnętrz.', 'images/img-00021.jpg'),
('Fotel salonowy brązowy', 699.99, 3, 'Wygodny fotel w brązowym kolorze, idealny do salonu lub gabinetu.', 'images/img-00022.jpg'),
('Stolik kawowy artystyczny', 359.99, 6, 'Drewniany stolik o unikalnym wyglądzie, artystyczny akcent do salonu.', 'images/img-00023.jpg'),
('Leżak składany drewniany', 199.99, 8, 'Składany leżak z naturalnego drewna, idealny na taras lub ogród.', 'images/img-00024.jpg'),
('Krzesło stylizowane drewniane', 219.99, 5, 'Drewniane krzesło stylizowane na antyk, doda charakteru każdemu wnętrzu.', 'images/img-00025.jpg'),
('Kanapa brązowa pofałdowana', 1149.00, 4, 'Średnia kanapa w brązowym kolorze z miękkim, pofałdowanym obiciem.', 'images/img-00026.jpg'),
('Sofa elegancka biała szeroka', 1549.00, 3, 'Szeroka, elegancka sofa w białym kolorze, pasująca do nowoczesnych wnętrz.', 'images/img-00027.jpg'),
('Krzesło proste ciemne', 129.99, 10, 'Proste, klasyczne krzesło drewniane w ciemnym kolorze.', 'images/img-00028.jpg'),
('Zestaw stolik + krzesło kremowe', 499.99, 6, 'Stylowy zestaw: kremowe krzesło i stolik, w artystycznym stylu.', 'images/img-00029.jpg'),
('Krzesło-leżak białe', 239.99, 5, 'Krzesło w kształcie leżaka, w eleganckim białym kolorze.', 'images/img-00030.jpg'),
('Kanapa rogowa brązowa', 1799.00, 2, 'Duża rogówka w brązowym odcieniu, wygodna i przestronna.', 'images/img-00031.jpg'),
('Kanapa rogowa czarna', 1799.00, 2, 'Czarna, duża rogówka o nowoczesnym wyglądzie i dużym komforcie.', 'images/img-00032.jpg'),
('Stolik okrągły biały', 229.99, 7, 'Prosty stolik w białym kolorze z okrągłym blatem, świetny do każdego wnętrza.', 'images/img-00033.jpg'),
('Sofa ciemnozielona', 999.00, 4, 'Nowoczesna sofa w głębokim zielonym kolorze, komfortowa i stylowa.', 'images/img-00034.jpg'),
('Fotel stylowy brązowy', 649.00, 5, 'Elegancki fotel z podłokietnikami w odcieniu brązu, stylowy dodatek do salonu.', 'images/img-00035.jpg'),
('Fotel retro szary', 549.00, 6, 'Szary fotel w stylu retro, z wygodnym siedziskiem i klasycznym kształtem.', 'images/img-00036.jpg'),
('Fotel retro czarny z podnóżkiem', 699.99, 4, 'Czarny fotel w stylu retro z dopasowanym podnóżkiem, stylowy i komfortowy.', 'images/img-00037.jpg');

