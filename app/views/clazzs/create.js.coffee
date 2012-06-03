$("<%= escape_javascript render(@clazz) %>").appendTo($(column<%= @clazz_amt % 3 %>)).hide().fadeIn();
clazzPageSetListeners();