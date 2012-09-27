module Lumberg
  module Cpanel
    class Email < Base
      def self.api_module; "Email"; end

      def checkmaindiscard; end

      # Add a forwarder
      #
      # ==== Required
      #  * <tt>:domain</tt> - Forwarder domain
      #  * <tt>:email</tt> - Local part ("user" if "user@domain.com")
      #  * <tt>:fwdopt</tt> - :pipe, :fwd, :system, :blackhole, or :fail
      #  * <tt>:fwdemail</tt> - Destination email address
      #
      # ==== Optional
      #  * <tt>:fwdsystem</tt> - System account to forward to. Should only be
      #                          used if "fwdopt" is set to "system"
      #  * <tt>:failmsgs</tt> - Set failure message. Only used if "fwdopt" is
      #                         set to "fail"
      #  * <tt>:pipefwd</tt> - Path to program to pipe to. Only used if 
      #                        "fwdopt" is set to "pipe"
      def add_forwarder(options = {})
        fwdopt_vals = [:pipe, :fwd, :system, :blackhole, :fail]
        unless fwdopt_vals.include?(options[:fwdopt].to_sym)
          raise "Invalid :fwdopt option"
        end

        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "addforward"
        }.merge(options))
      end

      # List forwarders
      #
      # ==== Optional
      #  * <tt>:domain</tt> - PENDING
      #  * <tt>:regex</tt> - PENDING
      def forwarders(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "listforwards"
        }.merge(options))
      end

      # Add a mailing list
      #
      # === Required
      #  * <tt>:list</tt> - Mailing liist name
      #  * <tt>:password</tt> - Mailing list password
      #  * <tt>:domain</tt> - Mailing list domain
      def add_mailing_list(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "addlist",
          :api_version  => 1, # :(
          "arg-0"       => options[:list],
          "arg-1"       => options[:password],
          "arg-2"       => options[:domain]
        })
      end

      # List Mailman mailing lists
      #
      # ==== Optional
      #  * <tt>:domain</tt> - PENDING
      #  * <tt>:regex</tt> - PENDING
      def mailing_lists(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "listlists"
        }.merge(options))
      end

      # List domains that can send/receive mail
      #
      # ==== Optional
      #  * <tt>:skipmain</tt> - PENDING
      def domains(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "listmaildomains"
        }.merge(options))
      end

      # List mail exchanger information
      #
      # ==== Required
      #  * <tt>:domain</tt> - PENDING
      def mx(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "listmxs"
        }.merge(options))
      end

      # Set mail delivery for a domain
      #
      # ==== Requires
      #  * <tt>:domain</tt> - PENDING
      #  * <tt>:delivery</tt> - PENDING
      def set_mail_delivery(options = {})
        delivery_vals = [:local, :remote, :auto, :secondary]
        unless delivery_vals.include?(options[:delivery].to_sym)
          raise "Invalid :delivery option"
        end

        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "setalwaysaccept",
          :mxcheck      => options[:delivery]
        }.merge(options))
      end

      def getalwaysaccept; end
      def listfilters; end
      def fetchcharmaps; end
      def listautoresponders; end
      def listdomainforwards; end

      # Add a POP account
      #
      # ==== Required
      #  * <tt>:domain</tt> - Domain for the email account
      #  * <tt>:email</tt> - Local part of email address. 
      #                      "user" if "user@domain"
      #  * <tt>:password</tt> - Password for email account
      #  * <tt>:quota</tt> - Disk space quota in MB. 0 for unlimited
      def add_account(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "addpop"
        }.merge(options))
      end

      # List email accounts. Uses the cPanel-preferred
      # API call Email::listpopswithdisk
      #
      # ==== Optional
      #  * <tt>:domain</tt> - PENDING
      #  * <tt>:regex</tt> - PENDING
      def accounts(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "listpopswithdisk"
        }.merge(options))
      end

      # List email accounts.
      # Uses Email::listpops; you probably want to use #accounts
      #
      # ==== Optional
      #  * <tt>:regex</tt> - PENDING
      def accounts_(options = {})
        perform_request({
          :api_module   => self.class.api_module,
          :api_function => "listpops"
        }.merge(options))
      end

      # List email accounts.
      # Uses Email::listpopswithimage; you probably want to use #accounts
      def accounts_with_image(options = {})
        perform_request(
          :api_module   => self.class.api_module,
          :api_function => "listpopswithimage"
        )
      end

      # List email accounts.
      # Uses Email::listpopssingle; you probably want to use #accounts
      def accounts_single(options = {})
        perform_request(
          :api_module   => self.class.api_module,
          :api_function => "listpopssingle"
        )
      end

      def listdefaultaddresses; end
      def getabsbrowsedir; end
      def browseboxes; end
      def filterlist; end
      def tracefilter; end
      def fetchautoresponder; end
      def getdiskusage; end

      def listfilterbackups; end
      def listaliasbackups; end

    end
  end
end
