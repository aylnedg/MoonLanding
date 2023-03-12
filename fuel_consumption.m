function fuel = fuel_consumption(u, fuel_init, v_init, h_init, h_target, v_target, t_man, t_step, t_freq)
    % Control input is constant over time intervals of length t_freq
    t = 0;
    fuel = fuel_init;
    v = v_init;
    h = h_init;
    while h(1) > h_target
        % Compute control input
        if t <= t_man
            u_t = u;
        else
            u_t = 0;
        end
        % Propagate dynamics over time interval t_step
        [v, h, fuel_burned] = dynamics(u_t, v, h, t_step);
        % Update time and fuel
        t = t + t_step;
        fuel = fuel - fuel_burned;
        % Check if fuel has been depleted
        if fuel < 0
            fuel = 0;
            break;
        end
        % Wait for next control input
        if mod(t, t_freq) == 0 && t <= t_man
            pause(t_freq - t_step);
        end
    end
    fuel = fuel_init - fuel;
end
