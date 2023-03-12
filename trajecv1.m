mu    = 4903; % [km^3/s^2]
Rm    = 1737; % [km]
ft2km = 0.0003048; %1 ft 0.0003048 km
nm2km = 1.85200; %1 nm 1.85200 km
g0    = 9.81; % [m/s^2]

%define spacecraft properties
Isp = 311; % [s]
fuel_init  = 8165; %available fuel mass [kg]
md  = 6531; %dry mass [kg]

%initial state (descent elliptical orbit)
rp  = Rm+50000*ft2km; %perigee radius [km]
ra  = Rm+60*nm2km; %apogee radius [km]
sma = (rp+ra)/2; %semimajor axis [km]
vp  = sqrt(2*((-mu/(2*sma))+mu/rp)); %perigee velocity [km/s]
va  = sqrt(2*((-mu/(2*sma))+mu/ra)); %apogee velocity [km/s]
mi  = fuel_init+md; % [kg]
h_init  = [rp;0]; %initial position vector [km]
v_init  = [0;-vp]; %initial velocity vector [km/s]

%final state(high gate)
h_target = 7000*ft2km; %target altitude [km]
v_target = 500*ft2km; %target velocity [km/s]


% İtki süresi ve sıklığı
t = 9*60; % s
dt = 1; % s

% Kontrol parametreleri
% Burada, itki büyüklüğünü optimize ediyoruz ve itki süresi ve sıklığı sabit alıyoruz.
u_min = 0; % Minimum itki büyüklüğü (N)
u_max = 44042; % Maksimum itki büyüklüğü (N)
t_step = 0.1; % İtki süresi (s)
t_freq = 1; % İtki sıklığı (s)

% Hedef fonksiyonu
% Burada, itki büyüklüğünü minimize etmek için yakıt tüketimini hesaplıyoruz.

fun = @(u) fuel_consumption(u, fuel_init, v_init, h_init, h_target, v_target, t_man, t_step, t_freq);

% Kısıtlama fonksiyonu
% Burada, son durum kısıtı ve yakıt kısıtını tanımlıyoruz.
nonlcon = @(u) constraints(u, fuel_init, v_init, h_init, h_target, v_target, t_man, t_step, t_freq);

% Başlangıç değeri
u0 = u_min;

% Kontrol parametrelerinin sınırları
lb = u_min;
ub = u_max;

% fmincon fonksiyonunu çağıralım
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
[u_opt, fval] = fmincon(fun,u0,[],[],[],[],lb,ub,nonlcon,options);

% Son durumu kontrol edelim
[v_final, h_final, ~] = orbit(u_opt, fuel_init, v_init, h_init, t_man, t_step, t_freq);
fprintf('Final speed: %f ft/s\n', v_final);
fprintf('Final altitude: %f ft\n', h_final);
fprintf('Fuel consumption: %f lb\n', fuel_init - fval);
