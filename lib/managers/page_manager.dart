import 'package:flutter/material.dart';

class PageManager {
  PageManager(this._pageController);

  final PageController _pageController;
  //metodo para navegar entre as paginas

  int pageGo = 0;

  void setPage(int pageValue) {
    //verificar se pagina selecionada é igual a pagina inicial
    if (pageValue == pageGo) return; // não faz nada
    pageGo = pageValue;
    _pageController.jumpToPage(pageValue);
  }
}
