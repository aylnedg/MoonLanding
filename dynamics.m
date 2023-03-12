function [v, h, fuel_burned] = dynamics(u_t, v, h, t_step)
% Bu fonksiyon, verilen itki kuvvetine göre yeni bir hız ve konum hesaplar.
% Ayrıca, verilen itki süresi boyunca tüketilen yakıt miktarını hesaplar.

% Sabitler
mu = 4903; % [km^3/s^2]
g0 = 9.81; % [m/s^2]
Isp = 311; % [s]
fuel_init  = 8165; %available fuel mass [kg]

% Uçuş parametreleri
md = 6531; % dry mass [kg]
mi = md + fuel_init; % total mass [kg]

% İtki kuvveti
F = u_t / mi;

% Hız ve konum güncelleme
a = -mu / norm(h)^3 * h;
v = v + (a + F) * t_step;
h = h + v * t_step;

% Yakıt tüketimi
fuel_burned = F * Isp * g0 * t_step;

end
%Bu fonksiyon, verilen itki kuvvetine (u_t), mevcut hız (v), mevcut konum (h) ve zaman adımı (t_step) parametreleri ile çağrılır. İlk olarak, itki kuvveti ve toplam kütlenin kullanarak (md ve fuel_init değişkenleri kullanılarak hesaplanır), yeni bir ivme (a) hesaplanır. Sonra, mevcut hız ve konuma (v ve h) bu ivme ve itki kuvveti (F) kullanılarak yeni bir hız ve konum hesaplanır. Son olarak, bu süre boyunca tüketilen yakıt miktarı (fuel_burned) hesaplanır ve fonksiyon sonuçları olarak döndürülür.