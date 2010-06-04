module PublicHelper
    def current(args)
    if args.include?(params[:id])
      return 'current'
    end
  end
end
