require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
    test "received" do
        mail = OrderNotifier.received(orders(:one))
            assert_equal "Подтверждение заказа в Pragmatic Store", mail.subject
            assert_equal ["dave@example.org"], mail.to
            assert_equal ["depot@fancy_gifts_shop.net"], mail.from
            assert_match /<td>45&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.html_part.body.encoded
    end
 
    test "shipped" do
        mail = OrderNotifier.shipped(orders(:one))
            assert_equal "Заказ из Pragmatic Store отправлен", mail.subject
            assert_equal ["dave@example.org"], mail.to
            assert_equal ["depot@fancy_gifts_shop.net"], mail.from
            assert_match /<td>45&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.html_part.body.encoded
                        
    end

    test "admin_notified" do
        mail = OrderNotifier.admin_notified('Попытка неавторизованного доступа к таблице пластиковых карт')
            assert_equal "Error from the site www.depot.com !", mail.subject
            assert_equal ["admin@fancy_gifts_shop.net"], mail.to
            assert_equal ["depot@fancy_gifts_shop.net"], mail.from
            assert_match /\s*Попытка неавторизованного доступа/, mail.html_part.body.encoded
    end


end
