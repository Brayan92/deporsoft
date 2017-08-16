$(document).ready(function(){
        var form = $("#new_user");
        var validate_rules = {
            'user[first_name]': {required: true,lettersonly: true},
            'user[last_name]': {required: true, lettersonly: true},
            'user[email]': {required: true,isValidEmailAddress: true},
            'user[password]': {required: true,minlength: 6},
            'user[password_confirmation]':{required:true,minlength: 6}
        };
        var icon = '<i class="fa fa-times" style="color:red" aria-hidden="true"></i>';
        var validate_messages = {
            'user[first_name]': {required: icon + ' Campo requerido', lettersonly: icon + ' Solo se permiten letras.'},
            'user[last_name]': {required: icon + ' Campo requerido', lettersonly: icon + ' Solo se permiten letras.'},
            'user[email]': {required: icon + ' Campo requerido', isValidEmailAddress: icon + ' Correo invalido.'},
            'user[password]': {required: icon + ' Campo requerido', minlength: icon + ' Debe digitar mnimo 6 caracteres.'},
            'user[password_confirmation]':{required: icon + ' Campo requerido', minlength: icon + ' Debe digitar mínimo 6 caracteres.}
        };

        var validator = form.validate({
            rules: validate_rules,
            messages: validate_messages,
        });

        $.validator.addMethod("isValidEmailAddress",
        function(value, element) {
            var pattern = new RegExp(/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/);
            return pattern.test(value);
        });

        $.validator.addMethod("lettersonly",
        function(value, element) {
            return this.optional(element) || /^([a-zA-Z ÁÉÍÓÚÑáéíóúñ]+)$/.test(value);
        });

});
