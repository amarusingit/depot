class OrderNotifier < ApplicationMailer
  default from: 'Sam Ruby <depot@fancy_gifts_shop.net>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order
    mail to: order.email, subject: 'Подтверждение заказа в Pragmatic Store'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Заказ из Pragmatic Store отправлен'
  end

# Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.admin_notified.subject
  #
  def admin_notified(error_text_for_admin)
    @error_text_for_admin = error_text_for_admin
    mail to: 'admin@fancy_gifts_shop.net', subject: 'Error from the site www.depot.com !'
  end

end
