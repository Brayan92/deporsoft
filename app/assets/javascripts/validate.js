$(document).ready(function(){
        var form = $("#new_user");
        var validate_rules = {
            'user[first_name]': {required: true,lettersonly: true},
            'user[last_name]': {required: true, lettersonly: true},
            'user[email]': {required: true,isValidEmailAddress: true},
            'user[password]': {required: true,minlength: 6},
            'user[password_confirmation]':{required:true,minlength: 6},
            'g-recaptcha-response': {required: true},
        };
        var icon = '<i class="fa fa-times" style="color:red" aria-hidden="true"></i>';
        var validate_messages = {
            'user[first_name]': {required: icon + ' Campo requerido', lettersonly: icon + ' Solo se permiten letras.'},
            'user[last_name]': {required: icon + ' Campo requerido', lettersonly: icon + ' Solo se permiten letras.'},
            'user[email]': {required: icon + ' Campo requerido', isValidEmailAddress: icon + ' Correo invalido.'},
            'user[password]': {required: icon + ' Campo requerido', minlength: icon + ' Debe digitar mnimo 6 caracteres.'},
            'user[password_confirmation]':{required: icon + ' Campo requerido', minlength: icon + ' Debe digitar mínimo 6 caracteres.'},
            'g-recaptcha-response': {required: icon + ' Campo requerido', minlength: icon + ' Debe digitar mínimo 6 caracteres.'},
        };

        var validator = form.validate({
            modules: 'security',
            reCaptchaSize: 'normal',
            reCaptchaTheme: 'light',
            rules: validate_rules,
            messages: validate_messages,
        });

        var form_championship = $(".new_championship, .edit_championship");
        var validate_rules_championship = {
            'championship[name]': {required: true},
            'championship[date_initial_inscription]': {required: true, isValidateDateInitial: true},
            'championship[date_end_inscription]': {required: true,isValidateDateEnd: true},
            'championship[matches_simultanius]': {required: true},
            'championship[match_duration]':{required:true},
        };
        var icon = '<i class="fa fa-times" style="color:red" aria-hidden="true"></i>';
        var validate_messages_championship = {
            'championship[name]': {required: 'Campo requerido'},
            'championship[date_initial_inscription]': {required: 'Campo requerido', isValidateDateInitial: 'Fecha debe ser mayor o igual a la actual.'},
            'championship[date_end_inscription]': {required: 'Campo requerido',isValidateDateEnd:'Fecha debe ser mayor o igual a  al inicial.'},
            'championship[matches_simultanius]': {required: 'Campo requerido'},
            'championship[match_duration]':{required:'Campo requerido'},
        };

        var validator_championship = form_championship.validate({
            modules: 'security',
            rules: validate_rules_championship,
            messages: validate_messages_championship,
        });
        var form_team = $(".new_team, .edit_team");
        var validate_rules_team = {
            'team[name]': {required: true},
            'team[user_id]': {required: true},
            'team[championship_id]': {required: true},
        };
        var icon = '<i class="fa fa-times" style="color:red" aria-hidden="true"></i>';
        var validate_messages_team = {
            'team[name]': {required: 'Campo requerido'},
            'team[user_id]': {required: 'Campo requerido'},
            'team[championship_id]': {required: 'Campo requerido'},
        };

        var validator_team = form_team.validate({
            modules: 'security',
            rules: validate_rules_team,
            messages: validate_messages_team,
        });

        var form_player = $(".new_player, .edit_player");
        var validate_rules_player = {
            'player[first_name]': {required: true},
            'player[last_name]': {required: true},
            'player[tshirt_number]': {required: true},
            'player[team_id]': {required: true},
        };
        var icon = '<i class="fa fa-times" style="color:red" aria-hidden="true"></i>';
        var validate_messages_player = {
            'player[first_name]': {required: 'Campo requerido.'},
            'player[last_name]': {required: 'Campo requerido.'},
            'player[tshirt_number]': {required: 'Campo requerido.'},
            'player[team_id]': {required: 'Campo requerido.'},
        };

        var validator_player = form_player.validate({
            modules: 'security',
            rules: validate_rules_player,
            messages: validate_messages_player,
        });

        $.validator.addMethod("isValidEmailAddress",
        function(value, element) {
            var pattern = new RegExp(/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/);
            return pattern.test(value);
        });

        $.validator.addMethod("isValidateDateInitial",
        function(value, element) {
            var dateInitial = new Date(value); 
            var today       = new Date();
            if (dateInitial.getTime() + 86000 >= today.getTime()){
                 return true;
            }
            else{
                return false;
            }
        });
        $.validator.addMethod("isValidateDateEnd",
        function(value, element) {
            var dateInitial = new Date($('#championship_date_initial_inscription').val()); 
            var dateEnd     = new Date(value); 
            if (dateEnd.getTime() >= dateInitial.getTime()){
                 return true;
            }
            else{
                return false;
            }
        });

        $.validator.addMethod("lettersonly",
        function(value, element) {
            return this.optional(element) || /^([a-zA-Z ÁÉÍÓÚÑáéíóúñ]+)$/.test(value);
        });



});
