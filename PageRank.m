function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
  
  data = dlmread(nume, ' ', 0, 0);
  s = data(1, 1);
  val1 = data((s + 2), 1);
  val2 = data((s + 3), 1);
  
  PR1 = Iterative(nume, d, eps);
  PR2 = Algebraic(nume, d);
  N = size(PR1, 1);
  
  J = ones(N, 1);
  for i = 1 : N
    J(i) = i;
  endfor
  cpy = PR2;
  for i = 1 : N
    for j = i + 1 : N
      if cpy(j) >= cpy(i)
        temp = cpy(j);
        cpy(j) = cpy(i);
        cpy(i) = temp;
        temp = J(i);
        J(i) = J(j);
        J(j) = temp;
      endif
    endfor
  endfor
  
  F = ones(N, 1);
  for i = 1 : N
    F(i) = Apartenenta(cpy(i), val1, val2);
  endfor
  
  filename = strcat(nume, ".out");
  fout = fopen(filename, 'w');
  
  fprintf(fout, "%d\n", N);
  for i = 1 : N
    fprintf(fout, "%d\n", PR1(i));
  endfor
  fprintf(fout, "\n");
  for i = 1 : N
    fprintf(fout, "%d\n", PR2(i));
  endfor
  fprintf(fout, "\n");
  
  for i = 1 : N
    fprintf(fout, "%d %d %d\n", i, J(i), F(i));
  endfor
  fclose(filename);
endfunction