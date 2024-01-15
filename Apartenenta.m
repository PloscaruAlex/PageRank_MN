function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1

	if x < val1
    y = 0;
  elseif x > val2
    y = 1;
  else
    y = 1.053647 * x - 0.001041;
  end
  output_precision(6);
endfunction
