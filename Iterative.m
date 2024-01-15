function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

  data = dlmread(nume, ' ', 0, 0);
  s = data(1, 1);
  M(1:s,1:s) = data(2:s +1,:);
  val1 = data((s + 2), 1);
  val2 = data((s + 3), 1);

  A = zeros(s, s);
  for i = 1 : s
    for j = 3 : length(data(i+1,:))
      if data(i + 1, j) != 0
        A(i, data(i + 1, j)) = 1;
      endif
      if i == data(i + 1, j)
        A(i, data(i + 1, j)) = 0;
        M(i, 2) = M(i, 2) - 1;
      endif
    endfor
  endfor

  K = zeros(s, s);
  for i = 1 : s
    for j = 1 : s
      K(i, j) = A(i, j) / M(i, 2);
    endfor
  endfor
  K = transpose(K);

  N = size(K, 2);
  R = rand(N, 1);
  R = R ./ norm(R, 1);
  last_R = ones(N, 1) * inf;
  M_hat = (d .* K) + (((1 - d) / N) .* ones(N, N));
  dif = R - last_R; 
  while (max(abs(dif)) > eps)
    last_R = R;
    R = M_hat * R;
    dif = R - last_R;
  endwhile
  output_precision(6);
endfunction