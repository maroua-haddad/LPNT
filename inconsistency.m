%Cette fonction retourne le degré d'inconsistence d'une distribution
function [inc] = inconsistency(dist)
inc=1-max(dist);