output "private_key_pem" {
    value = acme_certificate.certificate.private_key_pem
    sensitive = true
}

output "certificate_pem" {
    value = acme_certificate.certificate.certificate_pem
}

output "certificate_p12" {
    value = acme_certificate.certificate.certificate_p12
    sensitive = true
}

output "certificate_url" {
    value = acme_certificate.certificate.certificate_url
}

output "certificate_domain" {
    value = acme_certificate.certificate.certificate_domain
}

output "certificate_id" {
    value = acme_certificate.certificate.id
}

output "certificate_p12_password" {
    value = random_password.password.result
    sensitive = true
}