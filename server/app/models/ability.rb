class Ability
  include CanCan::Ability

  def initialize(usuario)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities


    usuario ||= Usuario.new

    # Everyone
    can :read, :all
    cannot :index, Usuario

    # Admins
    if usuario.rol=='admin'
      can :manage, :all

    # Logged users
    # TO-DO check for non blocked user
    elsif usuario.id
      can :create, Respuesta
      can :update, Respuesta, :usuario_id=>usuario.id

      can :create, Pregunta
      can :update, Pregunta, :usuario_id=>usuario.id
      can :destroy, Pregunta, :usuario_id=>usuario.id
      
      can :create, Comentario
      can :update, Comentario, :usuario_id=>usuario.id

      can :create, Voto
      can :destroy, Voto, :usuario_id=>usuario.id

      can :destroy, Usuario, :id=>usuario.id
    end
  end
end
