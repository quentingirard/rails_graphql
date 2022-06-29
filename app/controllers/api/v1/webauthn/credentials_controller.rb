class Api::V1::Webauthn::CredentialsController < Api::V1::ApplicationController
  def create
    # Create WebAuthn Credentials from the request params
    webauthn_credential = WebAuthn::Credential.from_create(params[:credential])

    begin
      # Validate the challenge
      # TODO: FIXE IT
      webauthn_credential.verify(params[:challenge])

      # The validation would raise WebAuthn::Error so if we are here, the credentials are valid, and we can save it
      credential = current_api_v1_user.webauthn_credentials.new(
        external_id: webauthn_credential.id,
        public_key: webauthn_credential.public_key,
        sign_count: webauthn_credential.sign_count
      )

      if credential.save
        render json: { credential: credential }, status: :created
      else
        render json: { error: "Couldn't add your Security Key" }
      end
    rescue WebAuthn::Error => e
      render json: { error: "Verification failed: #{e.message}" }
    ensure
      # session.delete(:webauthn_credential_register_challenge)
    end
  end
end
