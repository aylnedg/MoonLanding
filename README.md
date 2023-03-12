# MoonLanding
Bir apollo aracı, 50000ft lik perigeeeden 7000ft yüksekliğe ve 500ft/s hıza frenleme manevrası ile inmek istiyor. Manevra 9 dakika sürmelidir ve minimum yakıt tüketimi hedeflenmektedir.

İlk adım olarak, problemimizde optimize edeceğimiz kontrol parametrelerini belirleyelim. Bu parametreler, manevranın süresi, itkinin büyüklüğü ve itki sıklığı olabilir. Biz burada, itkinin büyüklüğünü kontrol edeceğiz ve itki süresi ve sıklığı sabit olarak alınacak.

Kontrol parametresini belirledikten sonra, hedef fonksiyonumuzu tanımlayabiliriz. Burada, minimum yakıt tüketimini hedeflediğimizden, hedef fonksiyonumuz, itki sırasında kullanılacak yakıt miktarının minimizasyonudur.

Ardından, kısıtlamalarımızı tanımlayabiliriz. İlk olarak, apollo aracımızın son durumunu hedef durumu ile eşleştiren bir eşitlik kısıtımız olacak. İkinci olarak, itki sırasında yakıtın sınırsız olmadığı gerçeği göz önüne alındığında, yakıt kısıtı koyacağız.

Son olarak, kontrol parametrelerinin sınırlarını belirleyeceğiz. Burada, itkinin minimum ve maksimum değerlerini belirleyeceğiz
