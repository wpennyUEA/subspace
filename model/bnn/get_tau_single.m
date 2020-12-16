function [tau_t] = get_tau_single (tau,t)

tau_t.u = tau.u(:,t);
tau_t.a = tau.a(t);
tau_t.r = tau.r(t);
tau_t.s = tau.s(t);
tau_t.c = tau.c(t);