DO
$$
BEGIN
    IF NOT EXISTS
    (
        SELECT 1 FROM core.attachment_lookup
        WHERE book = 'inventory.transfer.request'
    ) THEN
        INSERT INTO core.attachment_lookup(book, resource, resource_key)
        SELECT 'inventory.transfer.request', 'transactions.inventory_transfer_requests', 'inventory_transfer_request_id';
    END IF;

    IF NOT EXISTS
    (
        SELECT 1 FROM core.attachment_lookup
        WHERE book = 'inventory.transfer.delivery'
    ) THEN
        INSERT INTO core.attachment_lookup(book, resource, resource_key)
        SELECT 'inventory.transfer.delivery', 'transactions.inventory_transfer_deliveries', 'inventory_transfer_delivery_id';
    END IF;
END
$$
LANGUAGE plpgsql;

DO
$$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM config.messaging WHERE key='Enabled') THEN
        INSERT INTO config.messaging
        SELECT 'Enabled', 'false';
    END IF;

    IF NOT EXISTS(SELECT 1 FROM config.messaging WHERE key='ReplyToEmailAddress') THEN
        INSERT INTO config.messaging
        SELECT 'ReplyToEmailAddress', 'info@mixof.org';
    END IF;
END
$$
LANGUAGE plpgsql;

DO
$$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM core.config WHERE config_name='Quotation Valid Duration') THEN
        INSERT INTO core.config
        SELECT 3, 'Quotation Valid Duration';
    END IF;
END
$$
LANGUAGE plpgsql;