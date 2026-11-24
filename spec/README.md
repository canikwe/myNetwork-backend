# Specs

Run the suite with:

```bash
bundle exec rspec
```

## Characterization specs

Specs under `spec/requests/` record how the API behaves **today**, before the Rails upgrade and the frontend rewrite. They check status codes and parsed JSON, not raw bytes. Rule IDs in test names (for example `RULE-021`) refer to the business rules catalogued for the modernization.

## `legacy_defect` tag

Some current behaviour is a known defect, such as a `null` username being able to log in. Those specs still assert today's behaviour, so the upgrade can't change it by accident, and are tagged `legacy_defect`:

```ruby
it 'logs in as the user whose username is NULL', :legacy_defect do
```

The security-hardening phase fixes each defect, changes the spec to assert the fixed behaviour, and removes the tag.

List them with:

```bash
bundle exec rspec --tag legacy_defect
```
